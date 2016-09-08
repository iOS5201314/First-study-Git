//
//  Factory.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "Factory.h"

@implementation Factory

/** 向某个控制器上，添加返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"btn_back_h"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn bk_addEventHandler:^(id sender) {
        [vc.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    //使用弹簧控件缩小菜单按钮和边缘距离
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -20;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
}

+ (void)addBarButtonItem:(BarButtonItemType)barButtonItemType toVC:(UIViewController *)vc withTitle:(NSString *)title completionHandle:(void(^)(id sender))completionHandle{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithTitle:title style:UIBarButtonItemStylePlain handler:completionHandle];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 0;
    switch (barButtonItemType) {
        case BarButtonItemTypeLeft: {
            vc.navigationItem.leftBarButtonItems = @[spaceItem, item];
            break;
        }
        case BarButtonItemTypeRight: {
            vc.navigationItem.rightBarButtonItems = @[spaceItem, item];
            break;
        }
    }
}

@end












