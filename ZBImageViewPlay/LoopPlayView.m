//
//  LoopPlayView.m
//  ZBImageViewPlay
//
//  Created by qmap01 on 2017/6/28.
//  Copyright © 2017年 Zhaobin. All rights reserved.
//

#import "LoopPlayView.h"
#import "UIImageView+WebCache.h"
@interface  LoopPlayView ()<UIScrollViewDelegate>
{
    UIScrollView *loopView;
    UIImageView *leftView;
    UIImageView *middleView;
    UIImageView *rightView;
   

    NSInteger  currentIndex;
    NSInteger  count;
    
    UIPageControl *pageController;
    NSTimer *timer;
}

@end


@implementation LoopPlayView
static const int viewNum = 3;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        currentIndex  = 0;
   
    }
    return self;
}
- (void)setImageAry:(NSArray *)imageAry {
    /*
    NSUInteger fileSize=[[SDImageCache sharedImageCache]getSize];
    CGFloat size=fileSize/1024.0/1024.0;
    NSLog(@"缓存：%.4fM",size);
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDisk];
    */
    _imageAry = imageAry;
    count = _imageAry.count;
    [self createScrollview];
    [self createTimer];
    [self createPageControll];
}


- (void)createScrollview {
    loopView = [[UIScrollView alloc]initWithFrame:self.bounds];
    loopView.backgroundColor = [UIColor whiteColor];
    loopView.delegate =self;
    loopView.pagingEnabled = YES;
    loopView.bounces = NO;
    loopView.showsVerticalScrollIndicator=NO;
    loopView.showsHorizontalScrollIndicator=NO;
    loopView.contentSize = CGSizeMake(viewNum*self.frame.size.width, self.frame.size.height);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
    [loopView addGestureRecognizer:tapGesture];
    
    [self addSubview:loopView];
    
    leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    _isWebImage==YES?[leftView sd_setImageWithURL:[NSURL URLWithString:_imageAry[count-1]]]:(leftView.image=[UIImage imageNamed:_imageAry[count-1]]);
    
    middleView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    _isWebImage==YES?[middleView sd_setImageWithURL:[NSURL URLWithString:_imageAry[0]]]:(middleView.image=[UIImage imageNamed:_imageAry[0]]);
    
    rightView = [[UIImageView alloc]initWithFrame:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    _isWebImage==YES?[rightView sd_setImageWithURL:[NSURL URLWithString:_imageAry[1]]]:(rightView.image=[UIImage imageNamed:_imageAry[1]]);
    [loopView addSubview:leftView];
    [loopView addSubview:middleView];
    [loopView addSubview:rightView];
    
    //设置偏移量
    loopView.contentOffset = CGPointMake(self.frame.size.width, 0.f);
}
- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    timer  = [NSTimer timerWithTimeInterval:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerAction];
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction {
   
    [loopView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height) animated:YES];
}
- (void)invalidatetimer {
    [timer invalidate];
    timer = nil;
}
- (void)createPageControll {
    CGFloat pageControllerHeight = 20.f;
    CGFloat pageControllerWidth  = 80.f;
    pageController=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControllerWidth)*0.5, self.frame.size.height-pageControllerHeight, pageControllerWidth, pageControllerHeight)];
    pageController.numberOfPages = count;
    pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageController.currentPage = 0;
    [self addSubview:pageController];
}

#pragma mark - UIScrollerViewDelegate
//手动滑动停止减速时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x ==2*self.frame.size.width) {
        currentIndex++;
       
    }else if (scrollView.contentOffset.x==0) {
        currentIndex = currentIndex+count;
        currentIndex--;
    }
   
    [self resetImage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x ==2*self.frame.size.width) {
        currentIndex++;
        [self resetImage];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidatetimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self createTimer];
}
- (void)resetImage {
    if (_isWebImage) {
        [leftView sd_setImageWithURL:[NSURL URLWithString:_imageAry[(currentIndex-1)%count]]];
        [middleView sd_setImageWithURL:[NSURL URLWithString:_imageAry[(currentIndex)%count]]];
        [rightView sd_setImageWithURL:[NSURL URLWithString:_imageAry[(currentIndex+1)%count]]];
    }else {
        leftView.image = [UIImage imageNamed:_imageAry[(currentIndex-1)%count]];
        middleView.image = [UIImage imageNamed:_imageAry[(currentIndex)%count]];
        rightView.image = [UIImage imageNamed:_imageAry[(currentIndex+1)%count]];
    }
   //保持middleview
    loopView.contentOffset = CGPointMake(self.frame.size.width, 0.f);
    pageController.currentPage= (currentIndex)%count;
   
}
//手势点击
- (void)pageViewClick:(UITapGestureRecognizer *)tap
{
    if (self.mydelegate &&[self.mydelegate respondsToSelector:@selector(didSelectLoopViewWithNumber:)]) {
          [self.mydelegate didSelectLoopViewWithNumber:pageController.currentPage];
    }
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
