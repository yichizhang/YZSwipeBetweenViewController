//
//  Copyright (c) 2016 YICHI ZHANG
//  https://github.com/yichizhang
//  zhang-yi-chi@hotmail.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import "YZSwipeBetweenViewController.h"

@interface YZSwipeBetweenViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *_visibleViewControllers;

@end

@implementation YZSwipeBetweenViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (![self.viewControllers isEqualToArray:__visibleViewControllers]) {
        [self __setUp];
        [self __scrollToCurrentIndexAnimated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self __layout];
    [self __scrollToCurrentIndexAnimated:NO];
}

#pragma mark - Override setters / getters

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    [self setCurrentIndex:currentIndex animated:NO];
}

#pragma mark - Public Methods

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;

    // __visibleViewControllers exist, means that self has appeared
    if (__visibleViewControllers) {
        [self __setUp];
    }
}

- (void)setCurrentIndex:(NSUInteger)currentIndex animated:(BOOL)animated
{
    NSParameterAssert(currentIndex < self.viewControllers.count);

    _currentIndex = currentIndex;
    [self __scrollToCurrentIndexAnimated:NO];
}

#pragma mark - Private methods

- (void)__setUp
{
    [self __cleanViewControllers];
    [self __addViewControllers];
    [self __layout];
}

- (void)__cleanViewControllers
{
    for (UIViewController *vc in __visibleViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
        [vc didMoveToParentViewController:nil];
    }
}

- (void)__addViewControllers
{
    for (UIViewController *vc in self.viewControllers) {
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];

        vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    __visibleViewControllers = [self.viewControllers copy];

    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;

    NSUInteger maxCurrentIndex = __visibleViewControllers.count - 1;
    if (self.currentIndex > maxCurrentIndex) {
        self.currentIndex = maxCurrentIndex;
    }
}

- (void)__layout
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat originX = 0;

    self.scrollView.frame = CGRectMake(0.0, 0.0, width, height);

    for (UIViewController *vc in self.viewControllers) {
        vc.view.frame = CGRectMake(originX, 0.0, width, height);
        originX += width;
    }

    self.scrollView.contentSize = CGSizeMake(originX, height);
}

- (void)__scrollToCurrentIndexAnimated:(BOOL)animated
{
    if (!__visibleViewControllers) {
        return;
    }

    [self.scrollView scrollRectToVisible:[__visibleViewControllers[self.currentIndex] view].frame
                                animated:animated];
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat centerPos = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame) + 0.5;
    _currentIndex = (NSUInteger)centerPos;
}

@end
