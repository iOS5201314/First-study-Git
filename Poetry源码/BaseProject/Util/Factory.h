//
//  Factory.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BarButtonItemType) {
    BarButtonItemTypeLeft,
    BarButtonItemTypeRight,
};

@interface Factory : NSObject
/** 向某个控制器上，添加返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;

/** 想某个控制器, 添加导航栏上按钮 */
+ (void)addBarButtonItem:(BarButtonItemType)barButtonItemType toVC:(UIViewController *)vc withTitle:(NSString *)title completionHandle:(void(^)(id sender))completionHandle;
@end









