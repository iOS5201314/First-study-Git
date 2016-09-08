//
//  SearchPoetryViewModel.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "SearchPoetryViewModel.h"


@implementation SearchPoetryViewModel

@synthesize poetryList = _poetryList;

- (NSArray *)poetryList{
    if (_searchStr == nil || _searchStr.length == 0) {
        return nil;
    }
    if (_isNew) {
        _isNew = NO;
        self.poetryList = [PoetryModel poetryListWithSearchStr:_searchStr];
    }
    return _poetryList;
}

- (void)setSearchStr:(NSString *)searchStr{
    if ([searchStr isEqualToString:_searchStr]) {
        _isNew = NO;
    }else{
        _searchStr = searchStr;
        _isNew = YES;
    }
}

@end














