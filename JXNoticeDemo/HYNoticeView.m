//
//  HYNoticeView.m
//  HXSD
//
//  Created by JackXu on 16/4/30.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "HYNoticeView.h"

#define SIDELENGTH 10.0
#define TRIANGLE 5.0
#define NoticeColor [UIColor colorWithRed:248.0/255.0 green:77.0/255.0 blue:51.0/255.0 alpha:1]
static NSMutableArray *noticeArray;

@implementation HYNoticeView

#pragma mark - private method
- (void)drawRect:(CGRect)rect{
    //1.获得处理的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画三角形
    [self drawTriangle:ctx andRect:rect];
    //画矩形
    [self drawRectangle:ctx andRect:rect];
    CGContextClosePath(ctx);
}

-(void)drawTriangle:(CGContextRef)ctx andRect:(CGRect)rect{
    [NoticeColor set];
    CGContextMoveToPoint(ctx, (rect.size.width-10.0)*0.5, 0.0);
    
    CGPoint sPoints[3];//坐标点
    
    switch (_position) {
        case HYNoticeViewPositionTop:
            sPoints[0] =CGPointMake(rect.size.width*0.5, 0);//坐标1
            sPoints[1] =CGPointMake((rect.size.width-SIDELENGTH)*0.5, TRIANGLE);//坐标2
            sPoints[2] =CGPointMake((rect.size.width+SIDELENGTH)*0.5, TRIANGLE);//坐标3
            break;
        case HYNoticeViewPositionBottom:
            sPoints[0] =CGPointMake(rect.size.width*0.5, rect.size.height);//坐标1
            sPoints[1] =CGPointMake((rect.size.width-SIDELENGTH)*0.5, rect.size.height-TRIANGLE);//坐标2
            sPoints[2] =CGPointMake((rect.size.width+SIDELENGTH)*0.5, rect.size.height-TRIANGLE);//坐标3
            break;
        case HYNoticeViewPositionLeft:
            sPoints[0] =CGPointMake(0, rect.size.height*0.5);//坐标1
            sPoints[1] =CGPointMake(SIDELENGTH, rect.size.height*0.5-TRIANGLE);//坐标2
            sPoints[2] =CGPointMake(SIDELENGTH, rect.size.height*0.5+TRIANGLE);//坐标3
            break;
        case HYNoticeViewPositionRight:
            sPoints[0] =CGPointMake(rect.size.width, rect.size.height*0.5);//坐标1
            sPoints[1] =CGPointMake((rect.size.width-TRIANGLE), (rect.size.height-TRIANGLE)*0.5);//坐标2
            sPoints[2] =CGPointMake((rect.size.width-TRIANGLE), (rect.size.height+TRIANGLE)*0.5);//坐标3
            break;
        case HYNoticeViewPositionTopLeft:
            sPoints[0] =CGPointMake(rect.size.width*0.25, 0);//坐标1
            sPoints[1] =CGPointMake((rect.size.width*0.25-SIDELENGTH*0.5), TRIANGLE);//坐标2
            sPoints[2] =CGPointMake((rect.size.width*0.25+SIDELENGTH*0.5), TRIANGLE);//坐标3
            break;
        case HYNoticeViewPositionTopRight:
            sPoints[0] =CGPointMake(rect.size.width - 30, 0);//坐标1
            sPoints[1] =CGPointMake((rect.size.width-30-SIDELENGTH*0.5), TRIANGLE);//坐标2
            sPoints[2] =CGPointMake((rect.size.width-30+SIDELENGTH*0.5), TRIANGLE);//坐标3
            break;
        case HYNoticeViewPositionBottomRight:
            sPoints[0] =CGPointMake(rect.size.width - 30, rect.size.height);//坐标1
            sPoints[1] =CGPointMake((rect.size.width-30-SIDELENGTH*0.5), rect.size.height-TRIANGLE);//坐标2
            sPoints[2] =CGPointMake((rect.size.width-30+SIDELENGTH*0.5), rect.size.height-TRIANGLE);//坐标3
            break;
        default:
            break;
    }
    
    CGContextAddLines(ctx, sPoints, 3);//添加线
    CGContextDrawPath(ctx, kCGPathFillStroke); //根据坐标绘制路径
}

-(void)drawRectangle:(CGContextRef)ctx andRect:(CGRect)rect{
    CGRect rectangleRect;
    switch (_position) {
        case HYNoticeViewPositionTop:
        case HYNoticeViewPositionTopLeft:
        case HYNoticeViewPositionTopRight:
            rectangleRect = CGRectMake(0, TRIANGLE, rect.size.width, rect.size.height-TRIANGLE);
            break;
        case HYNoticeViewPositionBottom:
        case HYNoticeViewPositionBottomRight:
            rectangleRect = CGRectMake(0, 0, rect.size.width, rect.size.height-TRIANGLE);
            break;
        case HYNoticeViewPositionLeft:
            rectangleRect = CGRectMake(TRIANGLE, 0, rect.size.width-TRIANGLE, rect.size.height);
            break;
        case HYNoticeViewPositionRight:
            rectangleRect = CGRectMake(0, 0, rect.size.width-TRIANGLE, rect.size.height);
            break;
        default:
            break;
    }
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rectangleRect cornerRadius:2.0f];
    [NoticeColor setFill];
    [roundedRect fillWithBlendMode:kCGBlendModeNormal alpha:1];
}

-(void)execute:(void(^)())method after:(double)seconds{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        method();
    });
}

#pragma mark - public method
-(instancetype)initWithFrame:(CGRect)frame text:(NSString*)text position:(HYNoticeViewPosition)position closeBlock:(void(^)())closeBlock noticeBlock:(void(^)())noticeBlock{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _position = position;
        _closeClick = closeBlock;
        _noticeClick = noticeBlock;
        
        //文字
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        //
        UIButton *viewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [viewButton addTarget:self action:@selector(clickNotice:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewButton];
        _viewButton  = viewButton;
        
        //关闭按钮
        UIButton *closeButton = [[UIButton alloc] init];
        [closeButton setImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        _closeButton = closeButton;
        
        switch (position) {
            case HYNoticeViewPositionTop:
            case HYNoticeViewPositionTopLeft:
            case HYNoticeViewPositionTopRight:
                label.frame = CGRectMake(0, 4, frame.size.width, frame.size.height);
                closeButton.frame = CGRectMake(frame.size.width-16, 5, 14, 14);
                break;
            case HYNoticeViewPositionLeft:
                label.frame = CGRectMake(2, 0, frame.size.width, frame.size.height);
                closeButton.frame = CGRectMake(frame.size.width-16, 3, 14, 14);
                break;
            case HYNoticeViewPositionBottom:
            case HYNoticeViewPositionBottomRight:
                label.frame = CGRectMake(0, -2, frame.size.width, frame.size.height);
                closeButton.frame = CGRectMake(frame.size.width-16, 3, 14, 14);
                break;
            case HYNoticeViewPositionRight:
                label.frame = CGRectMake(-2, 0, frame.size.width, frame.size.height);
                closeButton.frame = CGRectMake(frame.size.width-20, 3, 14, 14);
                break;
                
            default:
                break;
        }
        
        NSRange rang = [text rangeOfString:@"查看方法"];
        if (rang.location!=NSNotFound) {
            closeButton.hidden = YES;
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
            [attString addAttribute:NSUnderlineStyleAttributeName
                              value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                              range:rang];
            [attString addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Palatino-Roman" size:15.0]
                              range:rang];
            label.attributedText = attString;
        }
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString*)text position:(HYNoticeViewPosition)position{
    return [self initWithFrame:frame text:text position:position closeBlock:nil noticeBlock:nil];
}

-(void)showType:(HYNoticeType)type inView:(UIView*)view {
    [view addSubview:self];
}

-(void)showType:(HYNoticeType)type inView:(UIView*)view closeBlock:(void(^)())closeBlock noticeBlock:(void(^)())noticeBlock{
    _closeClick = closeBlock;
    _noticeClick = noticeBlock;
}


-(void)showType:(HYNoticeType)type inView:(UIView*)view after:(CGFloat)after duration:(CGFloat)duration options:(UIViewAnimationOptions)options{
    _type = type;
    [view addSubview:self];
    self.hidden = YES;
    [self execute:^{
        [UIView transitionWithView:self duration:duration options:options animations:^{
            self.hidden = NO;
        } completion:nil];
    } after:after];
    
    self.tag = type;
    if (noticeArray == nil) {
        noticeArray = [NSMutableArray array];
    }
    
    for (int i = 0; i<noticeArray.count ; i++) {
        HYNoticeView *notice = noticeArray[i];
        if (notice.tag == type) {
            [noticeArray removeObject:notice];
        }
    }
    [noticeArray addObject:self];
}

-(void)clickClose:(UIButton*)button{
    [self removeFromSuperview];
    if (_closeClick) {
        self.closeClick();
    }
}

-(void)clickNotice:(UIButton*)button{
    if (_noticeClick) {
        self.noticeClick();
    }
}

+(void)hideNoticeWithType:(NSInteger)type{
    for (HYNoticeView *notice in noticeArray) {
        if (notice.tag == type) {
            [notice removeFromSuperview];
        }
    }
}



@end
