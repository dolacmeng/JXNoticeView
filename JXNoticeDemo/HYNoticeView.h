//
//  HYNoticeView.h
//  HXSD
//
//  Created by JackXu on 16/4/30.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, HYNoticeViewPosition) {
    HYNoticeViewPositionTop,
    HYNoticeViewPositionLeft,
    HYNoticeViewPositionBottom,
    HYNoticeViewPositionRight,
    HYNoticeViewPositionTopLeft,
    HYNoticeViewPositionTopRight,
    HYNoticeViewPositionBottomRight
};

typedef NS_ENUM(NSInteger, HYNoticeType) {
    HYNoticeTypeTestTop,
    HYNoticeTypeTestCall,
    HYNoticeTypeTestSearch,
    HYNoticeTypeTestHot
};

@interface HYNoticeView : UIView

@property (nonatomic,weak) UIButton *closeButton;
@property (nonatomic,assign) HYNoticeViewPosition position;
@property (nonatomic,assign) HYNoticeType type;
@property (nonatomic,strong) NSString *text;

-(instancetype)initWithFrame:(CGRect)frame text:(NSString*)text position:(HYNoticeViewPosition)position;

-(void)showType:(HYNoticeType)type inView:(UIView*)view;
-(void)showType:(HYNoticeType)type inView:(UIView*)view after:(CGFloat)after duration:(CGFloat)duration options:(UIViewAnimationOptions)options;

-(void)hide;
+(void)hideNoticeWithType:(NSInteger)type;
//-(void)clickClose:(UIButton*)button;

@end
