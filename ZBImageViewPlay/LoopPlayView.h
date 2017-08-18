//
//  LoopPlayView.h
//  ZBImageViewPlay
//
//  Created by qmap01 on 2017/6/28.
//  Copyright © 2017年 Zhaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoopPlayViewDelegate <NSObject>

- (void)didSelectLoopViewWithNumber:(NSInteger)selectNumber;

@end

@interface LoopPlayView : UIView
@property (nonatomic, strong) NSArray *imageAry;//可以是图片资源 或图片地址
@property (nonatomic ,assign) BOOL isWebImage;//是否网络图片
@property (nonatomic ,weak) id<LoopPlayViewDelegate> mydelegate;
@end
