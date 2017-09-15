//
//  YSMaskView.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSMaskView.h"

@interface YSMaskView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, copy) void(^completeCallback)(NSDictionary *info);

@end

@implementation YSMaskView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if ( self ) {
        [self initViews];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if ( self ) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5];
    self.maskView = [[UIView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT / 3, SCREEN_WIDTH, 2 * SCREEN_HEIGHT / 3)];
    self.maskView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.maskView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(100, 200, 100, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle: @"Close" forState: UIControlStateNormal];
    [btn addTarget: self action: @selector(closeAction) forControlEvents: UIControlEventTouchUpInside];
    
    [self.maskView addSubview: btn];
}

- (void)show
{
//    [UIView animateWithDuration: 0.3 animations:^{
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5];
//        self.maskView.frame = CGRectMake(0, SCREEN_HEIGHT / 3, SCREEN_WIDTH, 2 * SCREEN_HEIGHT / 3);
//    }];
}

- (void)closeAction
{
    
    if ( self.completeCallback ) {
        self.completeCallback(@{@"color" : [UIColor blueColor]});
    }
    
    [self removeFromSuperview];
}

#pragma mark - getter && setter 

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    _completeCallback = params[@"completeCallback"];
}

@end
