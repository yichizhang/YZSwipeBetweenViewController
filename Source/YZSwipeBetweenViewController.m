/*
 
 Copyright (c) 2014 Yichi Zhang
 https://github.com/yichizhang
 zhang-yi-chi@hotmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "YZSwipeBetweenViewController.h"

@interface YZSwipeBetweenViewController ()

@end

@implementation YZSwipeBetweenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:
                       mainScreenBounds
                       ];
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
    
    //self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.scrollView.contentSize =
    CGSizeMake(
               currentOriginX,
               mainScreenBounds.size.height
               );
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.contentOffset =
    CGPointMake(
                (self.viewControllers.count/2) * mainScreenBounds.size.width,
                0
                );
    
    [self.view addSubview:self.scrollView];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
