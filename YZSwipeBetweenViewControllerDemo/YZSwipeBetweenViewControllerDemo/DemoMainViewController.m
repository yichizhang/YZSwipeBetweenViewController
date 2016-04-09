/*

 Copyright (c) 2014 Yichi Zhang
 https://github.com/yichizhang
 zhang-yi-chi@hotmail.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 */

#import "DemoMainViewController.h"
#import "AppDelegate.h"

@interface DemoMainViewController ()

@property (nonatomic, strong) UIButton *pushVCButton;
@property (nonatomic, strong) UIButton *scrollVCButton;
@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UIButton *changeVCsButton;
@property (nonatomic, strong) UILabel *viewControllerDetailLabel;

@end

@implementation DemoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    float randomNum = ((float)rand() / RAND_MAX) * 1.0;

    self.view.backgroundColor = [UIColor colorWithHue:randomNum saturation:1.0 brightness:1.0 alpha:1.0];

    self.title = @"Demo VC";

    UIColor *fgColor = [UIColor colorWithWhite:1.0 alpha:1.00];
    UIColor *bgColor = [UIColor colorWithWhite:0.0 alpha:0.75];



    self.pushVCButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.pushVCButton setTitle:@"Push a VC" forState:UIControlStateNormal];
    [self.pushVCButton setTitleColor:fgColor forState:UIControlStateNormal];
    [self.pushVCButton setBackgroundColor:bgColor];

    [self.pushVCButton addTarget:self action:@selector(pushVCButtonTapped:) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.pushVCButton];



    self.scrollVCButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.scrollVCButton setTitle:@"Scroll To: (Select From Below)" forState:UIControlStateNormal];
    [self.scrollVCButton setTitleColor:fgColor forState:UIControlStateNormal];
    [self.scrollVCButton setBackgroundColor:bgColor];

    [self.scrollVCButton addTarget:self action:@selector(scrollVCButtonTapped:) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.scrollVCButton];



    self.changeVCsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.changeVCsButton setTitle:@"Replace All The VCs" forState:UIControlStateNormal];
    [self.changeVCsButton setTitleColor:fgColor forState:UIControlStateNormal];
    [self.changeVCsButton setBackgroundColor:bgColor];

    [self.changeVCsButton addTarget:self action:@selector(changeVCsButtonTapped:) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.changeVCsButton];




    self.segControl = [[UISegmentedControl alloc]
                       initWithItems:@[
                                       @"Index: 0",
                                       @"Index: 1",
                                       @"Index: 2"
                                       ]
                       ];
    self.segControl.tintColor = fgColor;
    self.segControl.backgroundColor = bgColor;
    [self.view addSubview:self.segControl];




    self.viewControllerDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.viewControllerDetailLabel.textColor = fgColor;
    self.viewControllerDetailLabel.backgroundColor = bgColor;
    self.viewControllerDetailLabel.text = self.description;
    [self.view addSubview:self.viewControllerDetailLabel];



    [self.segControl sizeToFit];

    [self.pushVCButton sizeToFit];
    [self.scrollVCButton sizeToFit];
    [self.changeVCsButton sizeToFit];
    [self.viewControllerDetailLabel sizeToFit];


}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];

    float centerY = self.view.center.y*0.4;
    float centerX = self.view.center.x;
    float buttonHeight = 36;

    self.pushVCButton.center = CGPointMake(centerX, centerY);
    centerY += buttonHeight*2;
    self.scrollVCButton.center = CGPointMake(centerX, centerY);
    centerY += buttonHeight;
    self.segControl.center = CGPointMake(centerX, centerY);
    centerY += buttonHeight*2;
    self.changeVCsButton.center = CGPointMake(centerX, centerY);
    centerY += buttonHeight*2;
    self.viewControllerDetailLabel.center = CGPointMake(centerX, centerY);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushVCButtonTapped:(id)sender{

    UIViewController *vc = [DemoMainViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)scrollVCButtonTapped:(id)sender{

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.swipeBetweenVC scrollToViewControllerAtIndex:self.segControl.selectedSegmentIndex];

}

- (void)changeVCsButtonTapped:(id)sender{

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate setupRootViewControllerForWindow];
    
}

@end
