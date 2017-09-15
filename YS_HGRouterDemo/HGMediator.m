//
//  HGMediator.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "HGMediator.h"

@implementation HGMediator

+ (instancetype)sharedInstance
{
    static HGMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[HGMediator alloc] init];
    });
    return mediator;
}

@end
