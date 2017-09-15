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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, YSModuleAViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [[NSMutableArray alloc] initWithArray: @[@"Push", @"push with callback", @"push with delegate", @"show alertView", @"pop custom View"]];
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

            [[HGMediator sharedInstance] HGRouterOpenTargetViewControllerWithUrl: [NSString stringWithFormat: @"higo://YSModuleAViewController.higo?json_params=%@", paramsString]];
            
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
            
        }
            break;
        case 6:
        {
            
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
