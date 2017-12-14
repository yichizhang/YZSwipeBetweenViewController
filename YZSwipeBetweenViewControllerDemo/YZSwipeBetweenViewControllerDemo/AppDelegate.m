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

#import "AppDelegate.h"
#import "DemoMainViewController.h"
#import "YZSwipeBetweenViewControllerDemo-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    [self setupRootViewControllerForWindow];

    [self.window makeKeyAndVisible];

    return YES;
}

- (void)setupRootViewControllerForWindow
{
    self.swipeBetweenVC = [YZSwipeBetweenViewController new];

    UIViewController *vc1 = [DemoMainViewController new];
    UINavigationController *navCon1 =
    [[UINavigationController alloc]initWithRootViewController:vc1];

    UIViewController *vc2 = [DemoMainViewController new];
    UINavigationController *navCon2 =
    [[UINavigationController alloc] initWithRootViewController:vc2];

    UIViewController *vc3 = [DemoMainViewController new];
    UINavigationController *navCon3 =
    [[UINavigationController alloc] initWithRootViewController:vc3];

    self.swipeBetweenVC.viewControllers = @[navCon1, navCon2, navCon3];
    self.swipeBetweenVC.currentIndex = (NSUInteger)self.swipeBetweenVC.viewControllers.count/2;
    
    self.window.rootViewController = self.swipeBetweenVC;
}

@end
