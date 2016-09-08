//
//  ShiListViewController.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import <UIKit/UIKit.h>
//因为UITableViewCell 是基础风格，不带右侧详情
//为了变为共有，即被其他类引用，需要在.h文件中声明


@interface ShiListViewController : UIViewController
- (id)initWithKind:(NSString *)kind;
@property(nonatomic,strong) NSString *kind;

@property(nonatomic,strong) NSString *introKind;
@end

@interface PoetryCell : UITableViewCell
@end











