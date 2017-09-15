//
//  HGMediator+HGMediatorCategory.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "HGMediator+HGMediatorCategory.h"

@implementation HGMediator (HGMediatorCategory)

#pragma mark - GET
- (UIViewController *)HGRouterGetTargetViewControllerWithUrl:(NSString *)url
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary: [YSURLGenerator URLrResolvingToParams: url]];
    
    return [self HGRouterGetTargetViewControllerWithParams: params];
}

- (UIViewController *)HGRouterGetTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params
{
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary: [YSURLGenerator URLrResolvingToParams: url]] ;
    [tmp addEntriesFromDictionary: params];
    return [self HGRouterGetTargetViewControllerWithParams: tmp];
}

- (UIViewController *)HGRouterGetTargetViewControllerWithParams:(NSDictionary *)params
{
    UIViewController *targetVC = [self performTarget: kModuleA
                                              action: kHGRouterActionGetTargetViewController
                                              params: params
                                   shouldCacheTarget: NO];
    
    if ( [targetVC isKindOfClass: [UIViewController class]] ) {
        return targetVC;
    }else{
        return nil;
    }
}

#pragma mark -  Open

- (void)HGRouterOpenTargetViewControllerWithParams:(NSDictionary *)params
{
    [self performTarget: kModuleA
                 action: kHGRouterActionOpenTargetViewController
                 params: params
      shouldCacheTarget: NO];
}

- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url
{
    [self HGRouterOpenTargetViewControllerWithParams: [YSURLGenerator URLrResolvingToParams: url]];
}

- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params
{
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary: [YSURLGenerator URLrResolvingToParams: url]];
    if ( params ) {
        [tmp addEntriesFromDictionary: params];
    }
    
    [self HGRouterOpenTargetViewControllerWithParams: tmp];
}

- (void)HGRouterOpenTargetViewControllerWithUrl:(NSString *)url extraParams:(NSDictionary *)params complete:(void(^)())complete
{
    NSMutableDictionary *tmpParams = nil;
    if ( params ) {
        tmpParams = [[NSMutableDictionary alloc] initWithDictionary: params];
    }else{
        tmpParams = [[NSMutableDictionary alloc] init];
    }
    
    if ( complete ) {
        [tmpParams setValue: complete forKey: @"completeCallback"];
    }
    
    [self HGRouterOpenTargetViewControllerWithUrl: url extraParams: tmpParams];
}

#pragma mark - AlertView

- (void)HGRouterShowAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction
{
    NSMutableDictionary *paramsSend = [[NSMutableDictionary alloc] init];
    
    if ( title ) {
        paramsSend[@"title"] = title;
    }
    if ( message ) {
        paramsSend[@"message"] = message;
    }
    if ( cancelAction ) {
        paramsSend[@"cancelAction"] = cancelAction;
    }
    if ( confirmAction ) {
        paramsSend[@"confirmAction"] = confirmAction;
    }
    
    [self performTarget: kModuleA
                 action: kHGRouterActionShowAlertViewController
                 params: paramsSend
      shouldCacheTarget: NO];
    
}

#pragma mark - show Custome View

- (void)HGRouterShowCustomMaskViewWithUrl:(NSString *)url complete:(void(^)(NSDictionary *info))complete
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary: [YSURLGenerator URLrResolvingToParams: url]];
    
    if ( complete ) {
        [params setValue: complete forKey: @"completeCallback"];
    }
    
    [self performTarget: kModuleA
                 action: kHGRouterActionShowCustomView
                 params: params
      shouldCacheTarget: NO];
}

#pragma mark - private methods
- (NSDictionary *)transUrlToParams:(NSString *)url
{
    return nil;
}

@end
