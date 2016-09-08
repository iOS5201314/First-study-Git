//
//  PoetryModel.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "BaseModel.h"

@interface PoetryModel : BaseModel

@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *shi;
@property(nonatomic,strong) NSString *introShi;
@property(nonatomic,strong) NSString *title;
@property(nonatomic) long ID;
@property(nonatomic,strong) NSString *author;

- (BOOL)removePoetry;
//通过字符串，搜索 诗名或者作者包含此字符串的诗
+ (NSArray *)poetryListWithSearchStr:(NSString *)searchStr;

+ (NSArray *)poetryListWithKind:(NSString *)kind;
@end











