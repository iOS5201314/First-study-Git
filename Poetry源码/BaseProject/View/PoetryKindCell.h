//
//  PoetryKindCell.h
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import <UIKit/UIKit.h>

@class PoetryKindCell;

@protocol PoetryKindCellDelegate <NSObject>

- (void)removePoetryKindCell:(PoetryKindCell *)poetryKindCell;

@end

@interface PoetryKindCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *delIV;

@property (weak, nonatomic) IBOutlet UIImageView *bgIV;

@property (weak, nonatomic) id<PoetryKindCellDelegate> delegate;


@end
