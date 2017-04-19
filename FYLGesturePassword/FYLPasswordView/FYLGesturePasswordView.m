//
//  FYLGesturePasswordView.m
//  FYLGesturePassword
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLGesturePasswordView.h"
#import "FYLCircleView.h"
#import "FYLResultView.h"

@interface FYLGesturePasswordView()
{
    CGPoint _currentPoint;//当前手指位置
    BOOL _showFailed;//密码错误展示错误路径
}
@property(nonatomic,strong)NSMutableArray *circleViews; //9个⭕️数组
@property(nonatomic,strong)UIView *viewGestureArea;     //装载9个⭕️的View
@property(nonatomic,strong)NSMutableArray *arrTemp;     //用户输入的密码数组
@property(nonatomic,strong)UILabel *labelTip;           //提示Label
@property(nonatomic,strong)FYLResultView *viewResult;   //上方展示结果的View
@end

@implementation FYLGesturePasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.arrTemp = [NSMutableArray arrayWithCapacity:9];
        [self setupUI];
    }
    return self;
}
#pragma mark - 布局UI
- (void)setupUI{
    ///上方展示结果的View
    _viewResult = [[FYLResultView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25,self.frame.size.height - SCREEN_WIDTH - 130 , 50, 50)];
    [self addSubview:_viewResult];
    
    ///提示Label
    _labelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - SCREEN_WIDTH - 80, SCREEN_WIDTH, 40)];
    _labelTip.textAlignment = NSTextAlignmentCenter;
    _labelTip.text = @"请输入手势密码";
    [self addSubview:_labelTip];
    
    ///装载9个⭕️的View
    _viewGestureArea = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - SCREEN_WIDTH - 40, SCREEN_WIDTH, SCREEN_WIDTH)];
    _viewGestureArea.backgroundColor = [UIColor clearColor];
    [self addSubview:_viewGestureArea];
    for (FYLCircleView *view in self.circleViews) {
        view.isSelected = NO;
        [_viewGestureArea addSubview:view];
    }
}

#pragma mark - 绘制路径
- (void)drawRect:(CGRect)rect {

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (_showFailed) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    }else
    {
        CGContextSetStrokeColorWithColor(ctx, KColorBlue.CGColor);
    }
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    int i = 0;
    CGPoint lastPoint = CGPointZero;
    for (NSNumber *num in self.arrTemp) {
        
        NSInteger index = [num integerValue];
        FYLCircleView *view = self.circleViews[index - 1];
        CGPoint point = [view convertPoint:CGPointMake(40, 40) toView:self];

        if (i == self.arrTemp.count - 1) {
            lastPoint = point;
        }
        
        if (i == 0) {
            CGContextMoveToPoint(ctx, point.x, point.y);
        }else
        {
            CGContextAddLineToPoint(ctx, point.x, point.y);
            CGContextStrokePath(ctx);
            CGContextMoveToPoint(ctx, point.x, point.y);
        }

        i++;
    }
    
    if (!CGPointEqualToPoint(lastPoint, CGPointZero)) {
        
        CGContextAddLineToPoint(ctx, _currentPoint.x, _currentPoint.y);
        CGContextStrokePath(ctx);
    }
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resetView];
    [self checkPointWithTouches:touches];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self checkPointWithTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self checkResult];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self checkResult];
}
#pragma mark - 结果处理
- (void)success{
    _labelTip.textColor = [UIColor greenColor];
    _labelTip.text = @"密码正确";
}
- (void)failed{
    _labelTip.textColor = [UIColor redColor];
    _labelTip.text = @"密码错误,请重新输入";
    
    _viewResult.arrResult = _arrTemp;
    _showFailed = YES;
    self.userInteractionEnabled = NO;
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetView];
    });
}

#pragma mark - 检测
- (void)checkPointWithTouches:(NSSet<UITouch *> *)touches{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:_viewGestureArea];
    
    _currentPoint = [touch previousLocationInView:self];
    [self setNeedsDisplay];
    for (FYLCircleView *view in self.circleViews) {
        if (CGRectContainsPoint(view.frame, point)) {
            if (view.isSelected == NO) {
                view.isSelected = YES;
                [self.arrTemp addObject:@(view.tag + 1)];
                [self setNeedsDisplay];
            }
            return;
        }
    }
   
}
- (BOOL)checkResult{
    
    BOOL result = NO;
    
    if (self.arrPassword.count != self.arrTemp.count) {
        [self failed];
        return result;
    }
    
    for (int i = 0; i<self.arrTemp.count; i++) {
        NSNumber *num1 = self.arrTemp[i];
        NSNumber *num2 = self.arrPassword[i];
        if ([num1 compare:num2] != NSOrderedSame) {
            [self failed];
            return result;
        }else if(i == self.arrTemp.count - 1){
            
            result = YES;
        }
    }
    [self success];
    return result;
}
#pragma mark - 重置
- (void)resetView{
    _viewResult.arrResult = nil;
    _showFailed = NO;
    self.userInteractionEnabled = YES;
    for (FYLCircleView *view in self.circleViews) {
        view.isSelected = NO;
    }
    [_arrTemp removeAllObjects];
    [self setNeedsDisplay];
}
#pragma mark - 懒加载
- (NSMutableArray *)circleViews{
    if (_circleViews == nil) {
        _circleViews = [NSMutableArray arrayWithCapacity:9];
        
        int hang = 0;
        int lie = 0;
        CGFloat width = SCREEN_WIDTH;
        for (int i = 0; i<9; i++) {
            hang = i/3;
            lie = i%3;
            
            FYLCircleView *circleView = [[FYLCircleView alloc] init];
            circleView.frame = CGRectMake(0, 0, 80, 80);
            circleView.center = CGPointMake(0.25*(lie+1)*width, 0.25*(hang+1)*width);
            circleView.tag = i;
            [_circleViews addObject:circleView];
        }
    }
    return _circleViews;
}

@end
