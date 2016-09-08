//
//  AppDelegate.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "AppDelegate.h"
#import "AppDelegate+Category.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
    [self movePoetryDBToDoc];
    
    [self configGlobalUIStyle];
    
    return YES;
}

/** 界面风格统一设置 */
- (void)configGlobalUIStyle{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"背景"] forBarMetrics:UIBarMetricsDefault];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITableView appearance] setSeparatorColor:[UIColor colorFromHexCode:@"9c896f"]];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorFromHexCode:@"534430"], NSFontAttributeName: [UIFont systemFontOfSize:22]}];
    /** searchbar中的取消按钮*/
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorFromHexCode:@"726754"]];
    
    UIView *selVie = [[UIView alloc] init];
    selVie.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1];
    [[UITableViewCell appearance] setSelectedBackgroundView:selVie];
}

/*
 因为要对数据库中的数据进行删除操作，但是app目录下的文件都是只读的，所以我们要复制一份到document文件夹下，以后就都对docment文件夹下的数据库做操作
 */
- (void)movePoetryDBToDoc{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Poetry" ofType:@"bundle"];
    path = [path stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"path %@", path);
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    docPath = [docPath stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"docPath %@", docPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:docPath]) {
        //[fileManager moveItemAtPath:path toPath:docPath error:nil];
        //需要改为复制 ，才能运行到真机上
        [fileManager copyItemAtPath:path toPath:docPath error:nil];
    }
}


@end
















