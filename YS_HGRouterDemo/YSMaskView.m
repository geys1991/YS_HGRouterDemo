//
//  YSMaskView.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSMaskView.h"
#import "YSModuleAModel.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface YSMaskView ()

@property (nonatomic, strong) UIView *maskView;

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
    self.maskView = [[UIView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 2 * SCREEN_HEIGHT / 3)];
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
    NSLog(@"%@", self);
    [UIView animateWithDuration: 0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.5];
        self.maskView.frame = CGRectMake(0, SCREEN_HEIGHT / 3, SCREEN_WIDTH, 2 * SCREEN_HEIGHT / 3);
    }];
}

- (void)closeAction
{
    if ( self.completeCallback ) {
        self.completeCallback(@{@"color" : randomColor});
    }
    
    [self removeFromSuperview];
}

#pragma mark - getter && setter 

- (void)setParams:(NSDictionary *)params
{
    [super setParams: params];
    
    // 自定义 View 会统一继承 HGBaseCustomView 为父类，父类主要的工作是设置 params 和 callBack 参数，不参与 UI 部分
    
    YSModuleAModel *modelA = [[YSModuleAModel alloc] initWithString: [params objectForKey: @"model"] error: nil];
    
    NSLog(@"%@", modelA);
    
}

@end
