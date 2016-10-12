//
//  CoverFlow.h
//  32 cover  flow效果
//
//  Created by wudi on 16/10/10.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverFlow : UICollectionViewFlowLayout

/** 默认中间item的scale为1.2 */
@property (nonatomic,assign) CGFloat middleItemScale;
/** 弧度值: item的旋转角度,默认为30度 */
@property (nonatomic,assign) CGFloat itemRadian;

@end
