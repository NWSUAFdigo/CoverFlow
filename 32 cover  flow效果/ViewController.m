//
//  ViewController.m
//  32 cover  flow效果
//
//  Created by wudi on 16/10/10.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "CoverFlow.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
}

- (void)setupCollectionView{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    CoverFlow *coverFlow = [[CoverFlow alloc] init];
    coverFlow.middleItemScale = 1.3;
    coverFlow.minimumLineSpacing = -50;
    coverFlow.itemSize = CGSizeMake(100, 130);
    
    self.collectionView.collectionViewLayout = coverFlow;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CoverFlow *coverFlow = (CoverFlow *)self.collectionView.collectionViewLayout;
    CGFloat offsetX = (coverFlow.itemSize.width + coverFlow.minimumLineSpacing) * 9;
   
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell.contentView.subviews.count == 0) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = cell.contentView.bounds;
        [cell.contentView addSubview:imageV];

        // 添加阴影
        imageV.layer.shadowColor = [UIColor grayColor].CGColor;
        imageV.layer.shadowOpacity = 0.5;
        imageV.layer.shadowOffset = CGSizeMake(0, 3);
        imageV.layer.shadowRadius = 10;
    }
    UIImage *image = [UIImage wd_imageNamed:[NSString stringWithFormat:@"%lu", indexPath.item + 1] cornerRadius:15];
    UIImageView *imageV = [cell.contentView.subviews lastObject];
    imageV.image = image;
    
    return cell;
}

@end
