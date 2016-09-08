//
//  BaseModel.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
//单例模式，返回唯一的数据库对象
+ (FMDatabase *)defaultDatabase;

@end












