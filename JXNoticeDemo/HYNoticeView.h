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

typedef void(^closeClickBlock)(void);
typedef void(^noticeClickBlock)(void);

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
@property (nonatomic,weak) UIButton *viewButton;
@property (nonatomic,assign) HYNoticeViewPosition position;
@property (nonatomic,assign) HYNoticeType type;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,copy) closeClickBlock closeClick;
@property (nonatomic,copy) noticeClickBlock noticeClick;

/** 初始化
 @param frame 气泡的frame
 @param text 文字
 @param position 尖角位置
 
 @return An initialized view object.
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString*)text position:(HYNoticeViewPosition)position;

/** 初始化
 @param frame 气泡的frame
 @param text 文字
 @param position 尖角位置
 @param closeBlock 点击关闭按钮的block
 @param noticeBlock 点击整个气泡的block
 
 @return An initialized view object.
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString*)text position:(HYNoticeViewPosition)position closeBlock:(void(^)())closeBlock noticeBlock:(void(^)())noticeBlock;


/** 显示notiveView
 @param type 用于区分的别名
 @param view 父view
*/
-(void)showType:(HYNoticeType)type inView:(UIView*)view;

/** 显示notiveView
 @param type 用于区分的别名
 @param view 父view
 @param after 延时执行
 @param duration 动画执行时长
 @param options 动画效果
 */
-(void)showType:(HYNoticeType)type inView:(UIView*)view after:(CGFloat)after duration:(CGFloat)duration options:(UIViewAnimationOptions)options;


/** 隐藏notiveView
 @param type 需要隐藏的notice的别名
 */
+(void)hideNoticeWithType:(NSInteger)type;

@end
