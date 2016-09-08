//
//  KindModel.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "BaseModel.h"

@interface KindModel : BaseModel

@property(nonatomic,strong) NSString *kind;
@property(nonatomic) long num;
@property(nonatomic,strong) NSString *introKind;
@property(nonatomic,strong) NSString *introKind2;

//删除当前数据
- (BOOL)removeKind;

+ (NSArray *)kinds;



@end











