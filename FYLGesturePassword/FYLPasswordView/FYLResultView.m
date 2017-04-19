//
//  FYLResultView.m
//  FYLGesturePassword
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLResultView.h"

@implementation FYLResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    int hang = 0;
    int lie = 0;
    CGFloat width = self.frame.size.width;
    for (int i = 0; i<9; i++) {
        hang = i/3;
        lie = i%3;
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 10, 10);
        view.center = CGPointMake(0.25*(lie+1)*width, 0.25*(hang+1)*width);
        view.tag = i;
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 1;
        view.clipsToBounds = YES;
        [self addSubview:view];
    }
}

- (void)setArrResult:(NSArray *)arrResult{
    if (_arrResult != arrResult) {
        _arrResult = arrResult;
    }
    
    for (UIView *view in self.subviews) {
        
        if ([arrResult containsObject:[NSNumber numberWithInteger:view.tag+1]]) {
            view.backgroundColor = [UIColor redColor];
        }else
        {
             view.backgroundColor = [UIColor whiteColor];
        }
    }
    
}

@end
