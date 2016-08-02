//
//  ViewController.m
//  JXNoticeDemo
//
//  Created by JackXu on 16/8/2.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "ViewController.h"
#import "HYNoticeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //顶部提示
    HYNoticeView *noticeTop = [[HYNoticeView alloc] initWithFrame:CGRectMake(50, 66, 250, 40) text:@"这里可以查询全城婚礼人的档期哦！" position:HYNoticeViewPositionTop];
    [noticeTop showType:HYNoticeTypeTestTop inView:self.view after:1.0 duration:0.6 options:UIViewAnimationOptionTransitionCurlDown];
    
    
    //电话提示
    HYNoticeView *noticeCall = [[HYNoticeView alloc] initWithFrame:CGRectMake(SCREENW-110, SCREENH-100, 100, 40) text:@"一键拨号" position:HYNoticeViewPositionBottomRight];
    [noticeCall showType:HYNoticeTypeTestCall inView:self.view after:1.0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft];
    
    //查找档期提示
    HYNoticeView *noticeSearch = [[HYNoticeView alloc] initWithFrame:CGRectMake(120, 200, 160, 40) text:@"快速查找团队档期" position:HYNoticeViewPositionRight];
    [noticeSearch showType:HYNoticeTypeTestSearch inView:self.view after:1.0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
    
    //热门提示（不带动画）
    HYNoticeView *noticeHot = [[HYNoticeView alloc] initWithFrame:CGRectMake(112, 300, 190, 40) text:@"怎样进入热门？ 查看方法" position:HYNoticeViewPositionLeft];
    [noticeHot showType:HYNoticeTypeTestHot inView:self.view];

}


@end
