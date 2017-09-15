//
//  HGMediator+HGMediatorCategory.h
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "HGMediator.h"

typedef NS_ENUM(NSInteger, HGTransitionType) {
    HGTransitionTypePush = 0,
    HGTransitionTypePresent,
    HGTransitionTypeCustome,
};

@interface HGMediator (HGMediatorCategory)

- (UIViewController *)HGRouterGetTargetViewControllerWithUrl:(NSString *)url;
- (UIViewController *)HGRouterGetTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params;
- (UIViewController *)HGRouterGetTargetViewControllerWithParams:(NSDictionary *)params;

- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url;
- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params;
- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params complete:(void(^)())complete;

- (void)HGRouterShowAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;

- (void)HGRouterShowCustomMaskViewWithUrl:(NSString *)url complete:(void(^)(NSDictionary *info))complete;

@end
