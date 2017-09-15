//
//  YSModuleAModel.h
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/14.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import <JSONModel.h>

typedef NS_ENUM(NSInteger, YSVCType) {
    YSVCTypeRed = 0,
    YSVCTypeBlue,
    YSVCTypeYellow,
};

@interface YSModuleAModel : JSONModel

@property (nonatomic,assign) NSInteger number;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) YSVCType vctype;

- (NSDictionary *)transitionToDictionary;

@end
