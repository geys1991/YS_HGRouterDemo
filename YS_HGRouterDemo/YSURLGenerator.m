//
//  YSURLGenerator.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/13.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSURLGenerator.h"

@implementation YSURLGenerator

+ (NSString *)URLGenerateByHostString:(NSString *)hostString Params:(NSDictionary *)params
{
    if ( !params ) {
        return @"";
    }
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: params
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *result = [NSString stringWithFormat: @"higo://%@.higo?params=%@", hostString, [[jsonString stringByReplacingOccurrencesOfString:@" " withString: @""] stringByReplacingOccurrencesOfString: @"\n" withString:@""]];
    
    return result;
}

+ (NSDictionary *)URLrResolvingToParams:(NSString *)url
{
    if ( !url ) {
        return @{};
    }
    
    NSString *charactersToEscape = @"!@#$^&%*+,;='\"`<>()[]{}\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    NSURL *urlTransformer = nil;
    if ( [url hasPrefix: @"higo:"] ) {
        urlTransformer = [[NSURL alloc] initWithString: [url stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacters]];  
    }
    
//    NSLog(@"scheme : %@, resourceSpecifier : %@, host : %@, port : %@, user : %@, password : %@, path : %@, fragment : %@, parameterString : %@, query : %@, relativePath : %@", urlTransformer.scheme, urlTransformer.resourceSpecifier, urlTransformer.host,urlTransformer.port, urlTransformer.user, urlTransformer.password, urlTransformer.path, urlTransformer.fragment, urlTransformer.parameterString, urlTransformer.query, urlTransformer.relativePath);
    
    NSString *targetStr = [[urlTransformer.host componentsSeparatedByString: @"."] firstObject];
    
    NSString *queryJsonString = [[[self URLDecodedString: urlTransformer.query] componentsSeparatedByString: @"="] lastObject];
    
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionaryWithDictionary: [self dictionaryWithJsonString: queryJsonString]];
    [queryDic setValue: targetStr forKey: @"Target"];
    
    return queryDic;
}

#pragma mark - private method

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 *  URLEncode
 */
+ (NSString *)URLEncodedString:(NSString *)str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
+ (NSString *)URLDecodedString:(NSString *)str
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = str;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


@end
