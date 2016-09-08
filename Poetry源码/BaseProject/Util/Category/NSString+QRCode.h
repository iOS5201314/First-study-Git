//
//  NSString+QRCode.h
//  BathCard
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (QRCode)

- (UIImage *)imageForQRCode:(CGFloat)width;

@end
