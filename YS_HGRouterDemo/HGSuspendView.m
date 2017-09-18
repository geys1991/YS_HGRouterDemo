//
//  HGSuspendView.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/18.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "HGSuspendView.h"

@interface HGSuspendView ()

//@property (nonatomic,assign) CGRect frame;

@end

@implementation HGSuspendView

- (instancetype)init
{
    self = [super init];
    if ( self ) {
//        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle: @"click" forState: UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [btn addTarget: self action: @selector(clickAction) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
}

- (void)changeBGColor:(UIColor *)color
{
    self.backgroundColor = color;
}

#pragma mark - Action

- (void)clickAction
{
    
}

#pragma mark - params

- (void)setParams:(NSDictionary *)params
{
    [super setParams: params];
    
    NSValue *frameValue = [NSValue valueWithCGRect: CGRectZero];
    if ( [params objectForKey: @"frame"] ) {
        frameValue = [params objectForKey: @"frame"];
    }
    
    self.frame = [frameValue CGRectValue];
    
    
}

@end
