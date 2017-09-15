//
//  Target_kModuleA.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/14.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "Target_kModuleA.h"

typedef void (^CTUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_kModuleA

- (void)Action_kHGRouterActionOpenTargetViewController:(NSDictionary *)params
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HGRouterTargetHostMap" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *targetClassString = [data objectForKey: [params objectForKey: @"Target"]];
    
    Class targetClass;
    NSObject *target = nil;
    
    if ( !targetClassString ) {
        targetClass = NSClassFromString([params objectForKey: @"Target"]);
        target = [[targetClass alloc] init];
        if ( !target ) {
            return;
        }
    }
    
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    [target setValue: params forKey: @"params"];
    
    if ( [params objectForKey: @"isSetDelegate"] ) {
        [target setValue: [self topViewController]  forKey: @"delegate"];
    }
    
    [[self topViewController].navigationController pushViewController: (UIViewController *)target  animated: YES];
}

- (void)Action_kHGRouterActionPresentTargetViewController:(NSDictionary *)params
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HGRouterTargetHostMap" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *targetClassString = [data objectForKey: [params objectForKey: @"Target"]];
    if ( !targetClassString ) {
        return;
    }
    
    Class targetClass;
    NSObject *target = nil;
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    [target setValue: params forKey: @"params"];
    
    if ( [params objectForKey: @"isSetDelegate"] ) {
        [target setValue: [self topViewController]  forKey: @"delegate"];
    }
    
    
    [[self topViewController] presentViewController: (UIViewController *)target animated: YES completion: nil];
}

- (id)Action_kHGRouterActionShowAlertViewController:(NSDictionary *)params
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CTUrlRouterCallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: params[@"title"] message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[self topViewController] presentViewController:alertController animated:YES completion:nil];
    return nil;
}

- (void)Action_kHGRouterActionShowCustomView:(NSDictionary *)params
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HGRouterTargetHostMap" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *targetClassString = [data objectForKey: [params objectForKey: @"Target"]];
    
    Class targetClass;
    NSObject *target = nil;
    
    if ( !targetClassString ) {
        targetClass = NSClassFromString([params objectForKey: @"Target"]);
        target = [[targetClass alloc] init];
        if ( !target ) {
            return;
        }
    }
    
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    [target setValue: params forKey: @"params"];
    
    [[self topViewController].navigationController.view addSubview: (UIView *)target];
    
    if ( [target respondsToSelector: @selector(show)] ) {
        [target performSelector:@selector(show) withObject: nil];
    }
}


#pragma mark - private methods

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end
