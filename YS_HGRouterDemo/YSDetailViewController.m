//
//  YSDetailViewController.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/19.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "YSDetailViewController.h"

@interface YSDetailViewController ()

@property (nonatomic,strong) NSDictionary *params;

@end

@implementation YSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = NSStringFromClass([self class]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setParams:(NSDictionary *)params
{
    _params = params;
}

@end
