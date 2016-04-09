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

@interface YZSwipeBetweenViewController ()

@end

@implementation YZSwipeBetweenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewControllersForScrollView];
}

#pragma mark - Private methods
- (void)removeViewControllersFromScrollView
{
    for (UIViewController *vc in self.viewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

- (void)addViewControllersToScrollView
{
    [self.scrollView removeFromSuperview];

    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    CGFloat currentOriginX = 0;

    for (UIViewController *vc in self.viewControllers) {
        CGRect frame = vc.view.frame;
        frame.origin.x = currentOriginX;
        vc.view.frame = frame;

        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];

        currentOriginX += mainScreenBounds.size.width;
    }

    self.scrollView.contentSize = CGSizeMake(currentOriginX,
                                             mainScreenBounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self scrollToViewControllerAtIndex:self.initialViewControllerIndex];

    [self.view addSubview:self.scrollView];
}

- (void)setupViewControllersForScrollView
{
    [self removeViewControllersFromScrollView];
    [self addViewControllersToScrollView];
}

#pragma mark - Public Methods
- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    [self setupViewControllersForScrollView];
}

- (void)reloadViewControllers
{
    [self setupViewControllersForScrollView];
}

- (void)scrollToViewControllerAtIndex:(NSInteger)index
{
    [self scrollToViewControllerAtIndex:index animated:NO];
}

- (void)scrollToViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated
{
    if (index >= 0 && index < self.viewControllers.count) {
        [self.scrollView scrollRectToVisible:[self.viewControllers[index] view].frame
                                    animated:animated];
    }
}

#pragma mark - Lazy loading of members
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:
                       [[UIScreen mainScreen] bounds]];
    }
    return _scrollView;
}

@end
