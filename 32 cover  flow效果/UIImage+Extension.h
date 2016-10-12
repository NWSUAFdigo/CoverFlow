//
//  UIImage+Extension.h
//  32 cover  flow效果
//
//  Created by wudi on 16/10/12.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)wd_imageNamed:(NSString *)name cornerRadius:(CGFloat)radius;
+ (UIImage *)wd_imageNamed:(NSString *)name cornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
