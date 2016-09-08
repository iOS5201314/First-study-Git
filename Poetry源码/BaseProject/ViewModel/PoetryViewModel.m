//
//  PoetryViewModel.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "PoetryViewModel.h"

@implementation PoetryViewModel
- (id)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}
- (NSInteger)rowNumber{
    return self.poetryList.count;
}
- (NSArray *)poetryList{
    _poetryList = [PoetryModel poetryListWithKind:_kind];
    return _poetryList;
}
- (PoetryModel *)poetryModelForRow:(NSInteger)row{
    return self.poetryList[row];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self poetryModelForRow:row].title;
}
- (NSString *)authorForRow:(NSInteger)row{
    return [self poetryModelForRow:row].author;
}
- (NSString *)shiForRow:(NSInteger)row{
    return [self poetryModelForRow:row].shi;
}
- (NSString *)shiIntroForRow:(NSInteger)row{
    return [self poetryModelForRow:row].introShi;
}
- (BOOL)removePoetryForRow:(NSInteger)row{
    return [[self poetryModelForRow:row] removePoetry];
}
@end














