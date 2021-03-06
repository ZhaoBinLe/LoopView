//
//  MainViewController.m
//  ZBImageViewPlay
//
//  Created by qmap01 on 2017/6/28.
//  Copyright © 2017年 Zhaobin. All rights reserved.
//

#import "MainViewController.h"
#import "LoopPlayView.h"
#import "CardBrowseView.h"
#import "AliPayLoading.h"
#import "AliPaySuccess.h"
@interface MainViewController ()<LoopPlayViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    // Do any additional setup after loading the view.
    LoopPlayView *loopview = [[LoopPlayView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height/3)];
    
#if 1
    loopview.isWebImage=YES;
#else
    loopview.isWebImage= NO;
#endif
    
    if (loopview.isWebImage) {
        loopview.imageAry = @[
                              @"http://img06.tooopen.com/images/20170321/tooopen_sy_202648845187.jpg",
                              @"http://img06.tooopen.com/images/20170106/tooopen_sy_195993938761.jpg",
                              @"http://img06.tooopen.com/images/20161120/tooopen_sy_187242348957.jpg",
                              @"http://img06.tooopen.com/images/20170306/tooopen_sy_200676715868.jpg",
                              @"http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg"
                              ];
    }else{
        
       loopview.imageAry = @[@"IMG_2016",@"IMG_2017",@"IMG_2018",@"IMG_2019",@"IMG_2020"];
    }
   

    loopview.mydelegate =self;

    [self.view addSubview:loopview];

    CardBrowseView *cardView = [[CardBrowseView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, self.view.frame.size.height/3)];
    [self.view addSubview:cardView];
    
    __block UIView *loadview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cardView.frame), self.view.frame.size.width, self.view.frame.size.height/4)];
    [AliPayLoading loadingShowIn:loadview];
    [self.view addSubview:loadview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AliPayLoading loadingHideIn:loadview];
        [loadview removeFromSuperview];
        loadview = nil;
        __block UIView *successView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cardView.frame), self.view.frame.size.width, self.view.frame.size.height/4)];
        [AliPaySuccess successShowIn:successView];
        [self.view addSubview:successView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [AliPaySuccess successHideIn:successView];
            [successView removeFromSuperview];
            successView = nil;
        });
    });
    
   
    
 
    

}
- (void)didSelectLoopViewWithNumber:(NSInteger)selectNumber {
    NSLog(@"%ld",(long)selectNumber);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
