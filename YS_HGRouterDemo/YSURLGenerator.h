//
//  YSURLGenerator.h
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/13.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSURLGenerator : NSObject

+ (NSString *)URLGenerateByHostString:(NSString *)hostString Params:(NSDictionary *)params;

+ (NSDictionary *)URLrResolvingToParams:(NSString *)url;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  URLEncode
 */
+ (NSString *)URLEncodedString:(NSString *)str;

/**
 *  URLDecode
 */
+ (NSString *)URLDecodedString:(NSString *)str;

@end
