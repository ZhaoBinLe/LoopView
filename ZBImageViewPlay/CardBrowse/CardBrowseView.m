//
//  CardBrowseView.m
//  ZBImageViewPlay
//
//  Created by qmap01 on 2018/7/18.
//  Copyright © 2018年 Zhaobin. All rights reserved.
//

#import "CardBrowseView.h"
@interface CardBrowseView()
{
    NSInteger _currentIndex;
    
    CGFloat _dragStartX;
    
    CGFloat _dragEndX;

}


@end

@implementation CardBrowseView

static float ITEMW = 140;
static float ITEMH = 180;
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
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width,200) collectionViewLayout:self.collectionViewlayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:self.collectionView];
}
-(CGFloat)collectionInset
{
    return self.frame.size.width/2.0f - ITEMW/2.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ITEMW, ITEMH);
}
//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
