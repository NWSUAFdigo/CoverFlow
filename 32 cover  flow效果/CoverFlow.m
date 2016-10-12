//
//  CoverFlow.m
//  32 cover  flow效果
//
//  Created by wudi on 16/10/10.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import "CoverFlow.h"

// 弧度转角度
#define angle(num) num / 180.0 * M_PI

@implementation CoverFlow

#pragma mark - 初始化
- (instancetype)init{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.middleItemScale = 1.2;
        self.itemRadian = 30;
    }
    return self;
}

#pragma mark - setter方法重写
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{
    // 最小的间距值不应该超过如下值
    CGFloat minium = self.itemSize.width * self.middleItemScale * 0.5 - self.itemSize.width;
    if (minimumLineSpacing < minium) {
        minimumLineSpacing = minium;
    }
    [super setMinimumLineSpacing:minimumLineSpacing];
}

- (void)setItemSize:(CGSize)itemSize{
    [super setItemSize:itemSize];
    [self setMinimumLineSpacing:self.minimumLineSpacing];
}

- (void)setMiddleItemScale:(CGFloat)middleItemScale{
    _middleItemScale = middleItemScale;
    [self setMinimumLineSpacing:self.minimumLineSpacing];
}

#pragma mark - 设置layout
- (void)prepareLayout{
    [super prepareLayout];   

    CGFloat inset = self.collectionView.bounds.size.width * 0.5 - self.itemSize.width * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // 获得collectionView的x轴中心线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 获取两个item的间距
    CGFloat interval = self.itemSize.width + self.minimumLineSpacing;
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        CGFloat distance = centerX - attr.center.x;
        distance = (distance > interval) ? interval : distance;
        distance = (distance < -interval) ? -interval : distance;
        
        CGFloat angle = angle(self.itemRadian) * distance / interval;
        
        CGFloat scale = 1.0 + (self.middleItemScale - 1.0) * (interval - ABS(distance)) / interval;
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0 / 500;
        transform = CATransform3DRotate(transform, angle, 0, 1, 0);
        transform = CATransform3DScale(transform, scale, scale, scale);
        attr.transform3D = transform;
    }
    
    // 让中间item在最前面显示(无法达到在最前面显示的效果,可能与设置了旋转有关)
    /*
    // 获得距离x轴中心点最近的itemIndex
    NSInteger centerIndex = [self centerIndexWithAttributes:attributes];
    UICollectionViewCell *centerCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:centerIndex inSection:0]];
    [self.collectionView bringSubviewToFront:centerCell];
     */
    
    return attributes;
}

- (NSInteger)centerIndexWithAttributes:(NSArray<UICollectionViewLayoutAttributes *> *)attributes{
    // 获得collectionView的x轴中心线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    CGFloat minDistance = MAXFLOAT;
    NSInteger centerIndex = 0;
    for (NSInteger i = 0; i < attributes.count; i++) {
        UICollectionViewLayoutAttributes *attr = attributes[i];
        
        if (ABS(minDistance) > ABS(attr.center.x - centerX)) {
            minDistance = attr.center.x - centerX;
            centerIndex = i;
        }
    }
    return centerIndex;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGSize collectionViewSize = self.collectionView.bounds.size;
    // 计算停止滚动时,collectionView显示出来的内容的frame
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, collectionViewSize.width, collectionViewSize.height);
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSInteger centerIndex = [self centerIndexWithAttributes:attributes];
    
    UICollectionViewLayoutAttributes *attr = attributes[centerIndex];
    
    return CGPointMake(attr.center.x - collectionViewSize.width * 0.5, proposedContentOffset.y);
}

@end
