//
//  ViewController.m
//  FYLGesturePassword
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "ViewController.h"
#import "FYLGesturePasswordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     本工程只展示了手势解锁功能,如需设置密码功能,可自行修改代码
     项目未借鉴任何其他代码.
     GitHub:https://github.com/konnitiha/FYLGesturePassword.git
    
    */
    
    FYLGesturePasswordView *view = [[FYLGesturePasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置密码
    view.arrPassword = @[@7,@5,@8,@6,@9];
    
    [self.view addSubview:view];
    
}

@end
