//
//  CardBrowseView.h
//  ZBImageViewPlay
//
//  Created by qmap01 on 2018/7/18.
//  Copyright © 2018年 Zhaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBrowseViewLayout.h"
@interface CardBrowseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)CardBrowseViewLayout *collectionViewlayout;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *data;
- (instancetype)initWithFrame:(CGRect)frame;

@end
