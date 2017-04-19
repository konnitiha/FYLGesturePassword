//
//  FYLCircleView.h
//  FYLGesturePassword
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define kScale_Horizontal (SCREEN_WIDTH/375.f)

#define KColorBlue [UIColor colorWithRed:65/255.f green:105/255.f blue:225/255.f alpha:1]
#define KColorBlue_Smoke [UIColor colorWithRed:65/255.f green:105/255.f blue:225/255.f alpha:0.4]

@interface FYLCircleView : UIView

@property(nonatomic,assign)BOOL isSelected;

@end
