//
//  SearchPoetryViewModel.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "PoetryViewModel.h"

@interface SearchPoetryViewModel : PoetryViewModel
{
    /** 判断字符串是否是新搜索,防止大量的重复搜索 */
    BOOL _isNew;
}
@property(nonatomic,strong) NSString *searchStr;
@end













