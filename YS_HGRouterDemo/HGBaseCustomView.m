//
//  HGBaseCustomView.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/18.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "HGBaseCustomView.h"

@interface HGBaseCustomView ()



@end

@implementation HGBaseCustomView

#pragma mark - params & callback 

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    if ( params[@"completeCallback"] ) {
        _completeCallback = params[@"completeCallback"];
    }
}

- (void)show
{
    
}

@end
