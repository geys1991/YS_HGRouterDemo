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
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
                                        configuration:config];
    
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.UIDelegate = self;

    self.webView.navigationDelegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:self.webView];
    
}

#pragma mark - UINavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ( [[navigationAction.request.URL absoluteString] containsString: @"243186478932011005"] ) {
        
        NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"YSDetailViewController" Params: nil];
        [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: paramsString];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - setter && getter

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    self.url = [params objectForKey: @"url"];
}

@end
