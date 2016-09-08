//
//  KindViewModel.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "BaseViewModel.h"
#import "KindModel.h"

@interface KindViewModel : BaseViewModel

@property(nonatomic) NSInteger rowNumber;
@property(nonatomic,strong) NSArray *kinds;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)detailForRow:(NSInteger)row;
- (BOOL)hasDetailForRow:(NSInteger)row;
- (BOOL)removeKindForRow:(NSInteger)row;

@end

















