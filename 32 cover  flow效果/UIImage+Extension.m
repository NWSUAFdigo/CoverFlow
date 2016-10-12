//
//  UIImage+Extension.m
//  32 cover  flow效果
//
//  Created by wudi on 16/10/12.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)wd_imageNamed:(NSString *)name cornerRadius:(CGFloat)radius{
//    UIImage *image = [UIImage imageNamed:name];
//    
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//    
//    CGRect pathRect = CGRectMake(0, 0, image.size.width, image.size.height);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:radius];
//    [path addClip];
//    [image drawInRect:pathRect];
////    path.lineWidth = 10;
////    [[UIColor orangeColor] setStroke];
////    [path stroke];
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    return resultImage;
    
    return [self wd_imageNamed:name cornerRadius:radius borderColor:nil borderWidth:0];
}

+ (UIImage *)wd_imageNamed:(NSString *)name cornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    UIImage *image = [UIImage imageNamed:name];
    CGSize contentSize = CGSizeMake(image.size.width + borderWidth * 2, image.size.height + borderWidth * 2);
    
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, 0);
    
    CGRect pathRect = CGRectMake(borderWidth * 0.5, borderWidth * 0.5, contentSize.width - borderWidth, contentSize.height - borderWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:radius];
    [path addClip];
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    path.lineWidth = borderWidth;
    [borderColor setStroke];
    [path stroke];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
