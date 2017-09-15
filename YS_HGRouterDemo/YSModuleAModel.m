//
//  YSModuleAModel.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/14.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSModuleAModel.h"
#import <objc/runtime.h>

@implementation YSModuleAModel

- (NSDictionary *)transitionToDictionary
{
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end
