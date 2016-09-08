//
//  KindViewModel.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "KindViewModel.h"

@implementation KindViewModel
- (NSInteger)rowNumber{
    return self.kinds.count;
}
- (NSArray *)kinds{
    return [KindModel kinds];
}

- (KindModel *)kindModelForRow:(NSInteger)row{
    return self.kinds[row];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self kindModelForRow:row].kind;
}
- (NSString *)detailForRow:(NSInteger)row{
    return [self kindModelForRow:row].introKind;
}
- (BOOL)hasDetailForRow:(NSInteger)row{
    return [self detailForRow:row].length != 0;
}
- (BOOL)removeKindForRow:(NSInteger)row{
    return [[self kindModelForRow:row] removeKind];
}

@end













