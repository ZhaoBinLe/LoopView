//
//  CardBrowseView.m
//  ZBImageViewPlay
//
//  Created by qmap01 on 2018/7/18.
//  Copyright © 2018年 Zhaobin. All rights reserved.
//

#import "CardBrowseView.h"


@implementation CardBrowseView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _collectionViewlayout = [[CardBrowseViewLayout alloc]init];
        [self initData];
        [self initView];
    }
    return self;
}
- (void)initData {
    self.data = @[@"IMG_2016",@"IMG_2017",@"IMG_2018",@"IMG_2019",@"IMG_2020"];
}
- (void)initView {
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 250, self.frame.size.width,200) collectionViewLayout:self.collectionViewlayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    UIImage *img = [UIImage imageNamed:self.data[indexPath.row]];
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    imgView.image = img;
    [cell.contentView addSubview:imgView];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(120, 140);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
