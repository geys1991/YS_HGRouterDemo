//
//  HGBaseCustomView.h
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/18.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGBaseCustomView : UIView

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, copy) void(^completeCallback)(NSDictionary *info);

- (void)show;

@end
