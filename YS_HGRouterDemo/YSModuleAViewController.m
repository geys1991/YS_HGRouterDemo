//
//  YSModuleAViewController.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/13.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSModuleAViewController.h"
#import "YSModuleAModel.h"
#import "YSProtocol.h"

@interface YSModuleAViewController ()

@property (nonatomic,weak) id<YSModuleAViewControllerDelegate> delegate;

@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,strong) YSModuleAModel *model;

@property (nonatomic,strong) UIColor *btnColor;

@property (nonatomic,strong) NSString *btnTitle;

@property (nonatomic,copy) void(^compete)();

@end

@implementation YSModuleAViewController

-(void)dealloc
{
    NSLog(@"**************Dealloc**************");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(100, 200, 100, 50)];
    btn.backgroundColor = self.btnColor;
    [btn setTitle: self.btnTitle forState: UIControlStateNormal];
    [self.view addSubview: btn];
    
    [btn addTarget: self action: @selector(clickAction) forControlEvents: UIControlEventTouchUpInside];
    
    self.title = NSStringFromClass([self class]);
    
    UIButton *modifyBtn = [[UIButton alloc] initWithFrame: CGRectMake(100, 300, 100, 50)];
    modifyBtn.backgroundColor = self.btnColor;
    [modifyBtn setTitle: @"修改 cell title" forState: UIControlStateNormal];
    [self.view addSubview: modifyBtn];
    
    [modifyBtn addTarget: self action: @selector(modifyTitle) forControlEvents: UIControlEventTouchUpInside];
    
}

#pragma mark - action

- (void)clickAction
{
    if ( self.compete ) {
        self.compete();
    }
    if ( [self.delegate respondsToSelector: @selector(clickBtn)] ) {
        [self.delegate clickBtn];
    }
}

- (void)modifyTitle
{
    if ( [self.delegate respondsToSelector: @selector(modifyCellTitle:)] ) {
        [self.delegate modifyCellTitle: @"changed cell title"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setter && getter 

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    self.model = [[YSModuleAModel alloc] initWithString: [_params objectForKey: @"model"] error: nil];
    self.btnColor = [_params objectForKey: @"btnColor"];
    self.btnTitle = [_params objectForKey: @"btnTitle"];
    self.compete = [_params objectForKey: @"completeCallback"];
}

@end
