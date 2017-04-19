//
//  FYLCircleView.m
//  FYLGesturePassword
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLCircleView.h"

@implementation FYLCircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGSize size = self.frame.size;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!_isSelected) {
        
        CGContextAddArc(ctx, size.width/2, size.height/2, size.width/2 - 1, 0, M_PI*2, 0);
        CGContextSetLineWidth(ctx, 2);
        [[UIColor lightGrayColor] set];
        
        CGContextStrokePath(ctx);
        
    }else
    {
        CGContextAddArc(ctx, size.width/2, size.height/2, size.width/2, 0, M_PI*2, 0);
        [KColorBlue_Smoke set];
        CGContextFillPath(ctx);
        
        
        CGContextAddArc(ctx, size.width/2, size.height/2, size.width/4, 0, M_PI*2, 0);
        [KColorBlue set];
        CGContextFillPath(ctx);
        
    }

}


- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

@end
