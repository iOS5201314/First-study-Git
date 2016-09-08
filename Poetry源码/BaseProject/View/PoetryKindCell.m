//
//  PoetryKindCell.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "PoetryKindCell.h"

@implementation PoetryKindCell
- (IBAction)removeItem:(id)sender {
    if (!self.delIV.hidden) {
        [self.delegate removePoetryKindCell:self];
    }
}

@end
