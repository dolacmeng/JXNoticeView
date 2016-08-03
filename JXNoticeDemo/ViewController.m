//
//  ViewController.m
//  JXNoticeDemo
//
//  Created by JackXu on 16/8/2.
//  Copyright © 2016年 BFMobile. All rights reserved.
//  Blog：http://blog.csdn.net/dolacmeng/article/details/52094808
//

#import "ViewController.h"
#import "HYNoticeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //顶部提示，带有弯曲掉下的动画
    HYNoticeView *noticeTop = [[HYNoticeView alloc] initWithFrame:CGRectMake(50, 66, 250, 40) text:@"这里可以查询全城婚礼人的档期哦！" position:HYNoticeViewPositionTop];
    [noticeTop showType:HYNoticeTypeTestTop inView:self.view after:1.0 duration:0.6 options:UIViewAnimationOptionTransitionCurlDown];
    noticeTop.closeClick = ^(){
        NSLog(@"closeClick!!");
    };
    
    //电话提示，带有右边翻转动画，并且有加减速的效果
    HYNoticeView *noticeCall = [[HYNoticeView alloc] initWithFrame:CGRectMake(SCREENW-110, SCREENH-100, 100, 40) text:@"一键拨号" position:HYNoticeViewPositionBottomRight];
    [noticeCall showType:HYNoticeTypeTestCall inView:self.view after:1.0 duration:1.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromLeft];
    
    //查找档期提示，从底部翻转的动画效果，自定义点击事件
    HYNoticeView *noticeSearch = [[HYNoticeView alloc] initWithFrame:CGRectMake(120, 200, 160, 40) text:@"快速查找团队档期" position:HYNoticeViewPositionRight closeBlock:^{
        NSLog(@"点击了关闭按钮");
    } noticeBlock:^{
        NSLog(@"点击了Notice");
    }];
    [noticeSearch showType:HYNoticeTypeTestSearch inView:self.view after:1.0 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom];
    
    //热门提示（不带动画）
    HYNoticeView *noticeHot = [[HYNoticeView alloc] initWithFrame:CGRectMake(112, 300, 190, 40) text:@"怎样进入热门？ 查看方法" position:HYNoticeViewPositionLeft];
    [noticeHot showType:HYNoticeTypeTestHot inView:self.view];
    
    //隐藏指定别名的notice
    [self performSelector:@selector(hide) withObject:nil afterDelay:4.0];
}

-(void)hide{
    [HYNoticeView hideNoticeWithType:HYNoticeTypeTestTop];
}


@end
