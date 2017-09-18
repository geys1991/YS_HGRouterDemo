//
//  ViewController.m
//  YS_HGRouterDemo
//
//  Created by geys1991 on 2017/9/13.
//  Copyright © 2017年 geys1991. All rights reserved.
//

#import "ViewController.h"
#import "moduleConst.h"
#import "YSURLGenerator.h"
#import "YSModuleAModel.h"
#import "YSProtocol.h"

#import "YSMaskView.h"
#import "HGMediator.h"
#import "HGMediator+HGMediatorCategory.h"

#import <YYKit/NSString+YYAdd.h>

//https://pages.w.lehe.com/glk/11471

//https://v.lehe.com/v7/goods/get_detail?access_token=5564d2a770415afc643fdb0f6d995654&account_id=233275965878032991&app=higo&client_id=1&cver=7.0.6&device_id=h_15c5ab2ad7b54cd5944bdd4c6fbfbad7&device_model=iPhone%206s&device_token=714e43eaed2b94668af91cf4eaa30ab84436bbd1733deb83bafe67416526c236&device_version=10.3.2&goods_id=241245753780029021&h=&idfa=5100B80F-1ABD-4BEB-9336-0806F7A574F1&open_udid=fe0252a8d706a8d95195be5accd7bd12a85bac39&package_type=1&qudaoid=10000&ratio=750%2A1334&s_nonse=92528319&s_sign=2a905ae0e0526044674d&s_st=1505727114&uuid=b9ed88ef591e133bec692c211d521af9&ver=0.8&via=iphone

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, YSModuleAViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [[NSMutableArray alloc] initWithArray: @[
                                                               @"Push",
                                                               @"push with callback",
                                                               @"push with delegate",
                                                               @"show alertView",
                                                               @"pop custom View",
                                                               @"show suspend view",
                                                               @"open url by webview"
                                                               ]];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UITableViewCell" forIndexPath: indexPath];
    
    cell.textLabel.text = [self.dataSource objectAtIndex: indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // URL 生成
    YSModuleAModel *model = [[YSModuleAModel alloc] init];
    model.name = @"Geys";
    model.number = 100;
    model.vctype = YSVCTypeBlue;
    
    NSDictionary *ppp = @{@"model" : [model toJSONString],
                          @"btnTitle" : @"Geys"};
    
    NSInteger selectedIndex = indexPath.row;
    switch (selectedIndex) {
        case 0:
        {
            NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"ModuleATarget_YSModuleAViewController" Params: ppp];
            [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: paramsString];
        }
            break;
        case 1:
        {
            NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"YSModuleAViewController" Params: ppp];
            [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: paramsString extraParams: @{@"btnColor": [UIColor redColor]} complete:^{
                self.view.backgroundColor = [UIColor redColor];
            }];
        }
            break;
        case 2:
        {
            NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"YSModuleAViewController" Params: ppp];
            [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: paramsString extraParams: @{@"btnColor": [UIColor redColor],
                                                                                                              @"isSetDelegate" : @YES} complete: nil];
        }
            break;
        case 3:
        {
            [[HGMediator sharedInstance] HGRouterShowAlertViewWithTitle:@"Alert View Title" message: nil cancelAction:^(NSDictionary *info) {
                NSLog(@"Cancel");
            } confirmAction:^(NSDictionary *info) {
                NSLog(@"Confirm");
            }];
        }
            break;
        case 4:
        {
            NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"YSMaskView" Params: ppp];
            [[HGMediator sharedInstance] HGRouterShowCustomMaskViewWithUrl: paramsString complete:^(NSDictionary *info){
                self.view.backgroundColor = [info objectForKey: @"color"];
            }];
        }
            break;
        case 5:
        {
            NSString *paramsString = [YSURLGenerator URLGenerateByHostString: @"HGSuspendView" Params: ppp];
            [[HGMediator sharedInstance] HGRouterShowCustomMaskViewWithUrl: paramsString extraParams: @{@"frame" : [NSValue valueWithCGRect: CGRectMake(0, 150, SCREEN_WIDTH, 300)]} complete: nil];
        }
            break;
        case 6:
        {
            [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: @"https://pages.w.lehe.com/glk/11471"];
        }
            break;
        case 7:
        {
            
        }
            break;
        default:
        {
            NSLog(@"");
        }
            break;
    }
}

#pragma mark - Action

- (IBAction)bottomBtnAction:(id)sender {
    
    UIView *customeView = [[HGMediator sharedInstance] HGRouterGetCustomViewWithIdentifier: @"HGSuspendView"];
    
    NSLog(@"%@", customeView);
    
    SEL action = NSSelectorFromString(@"changeBGColor");
    if ( [customeView respondsToSelector: action] ) {
        [[HGMediator sharedInstance] performTarget: @"HGSuspendView" action: @"changeBGColor" params: @{@"color" : [UIColor redColor]} shouldCacheTarget: YES];
    }

}


#pragma mark - YSModuleAViewControllerDelegate

- (void)clickBtn
{
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)modifyCellTitle:(NSString *)title
{
    [self.dataSource replaceObjectAtIndex: 2 withObject: @"changed Title"];
    [self.tableView reloadData];
}

@end
