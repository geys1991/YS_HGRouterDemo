//
//  YSWKWebViewController.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/15.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSWKWebViewController.h"
#import <WebKit/WebKit.h>


@interface YSWKWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,strong) NSURL *url;

@property (nonatomic,strong) WKWebView *webView;


@end

@implementation YSWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    //是否内联视频播放，而不是全屏播放
    config.allowsInlineMediaPlayback = YES;
    if ([config respondsToSelector:@selector(setMediaTypesRequiringUserActionForPlayback:)]) {
        [config setMediaTypesRequiringUserActionForPlayback:WKAudiovisualMediaTypeNone];
    }
    else if ([config respondsToSelector:@selector(setRequiresUserActionForMediaPlayback:)]) {
        config.requiresUserActionForMediaPlayback  = NO;
    }
    else{
        
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height - 64))
                                        configuration:config];
    
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.UIDelegate = self;

//    NSURL *webURL = [NSURL URLWithString: self.url];

    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setter && getter

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    self.url = [params objectForKey: @"url"];
}

@end
