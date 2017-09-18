//
//  moduleConst.h
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/13.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#ifndef moduleConst_h
#define moduleConst_h


#define SCREEN_HEIGHT           MainScreenHeight()
#define SCREEN_WIDTH            MainScreenWidth()
#define SCREEN_SCALE            [[UIScreen mainScreen] scale]
#define SCALE(a)         (SCREEN_SCALE > 0.0 ? (a) / SCREEN_SCALE : (a))

static __inline__ CGFloat MainScreenWidth()
{
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
}

static __inline__ CGFloat MainScreenHeight()
{
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}

// moduleName
#define kModuleA @"kModuleA"
#define kModuleB @"kModuleB"

//// ActionKey
#define kHGRouterActionGetTargetViewController @"kHGRouterActionGetTargetViewController" //  获取目标视图控制器（应该不仅仅局限于视图控制器，之后会想想是否可以统一 获取目标控制器,目标 view）
#define kHGRouterActionOpenTargetViewController @"kHGRouterActionOpenTargetViewController" // Push 到目标视图控制器
#define kHGRouterActionPresentTargetViewController @"kHGRouterActionPresentTargetViewController" // Present 到目标视图控制器

#define kHGRouterActionShowAlertViewController @"kHGRouterActionShowAlertViewController" // 弹出 AlertView

#define kHGRouterActionGetCustomView @"kHGRouterActionGetCustomView" // 返回 CustomView
#define kHGRouterActionShowCustomView @"kHGRouterActionShowCustomView" // 弹出 CustomView



//#define kHGRouterActionPushTargetViewController @"kHGRouterActionPushTargetViewController"
//NSString * const kHGRouterActionNativPresentTargetViewController = @"kHGRouterActionNativPresentTargetViewController";  // Present 到目标视图控制器
//
//NSString * const kHGRouterActionNativePresentImage = @"nativePresentImage";
//NSString * const kHGRouterActionShowAlert = @"showAlert";
////NSString * const kHGRouterActionCell = @"cell";
//NSString * const kHGRouterActionConfigCell = @"configCell";

#endif /* moduleConst_h */
