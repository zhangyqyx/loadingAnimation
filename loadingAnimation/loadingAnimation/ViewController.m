//
//  ViewController.m
//  loadingAnimation
//
//  Created by 张永强 on 16/10/14.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ViewController.h"
#import "ZYLoadingView.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource>
/** 动画数组 */
@property (nonatomic , strong)NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加载动画效果";
    self.dataSource = @[@"圆形加载动画" , @"直线加载动画", @"圆点加载动画", @"圆圈加载动画", @"闪烁动画" ,@"旋转动画"];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.frame;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = self.dataSource[indexPath.row];
    switch (indexPath.row) {
        case 0:
            //加载圆形动画
            [ZYLoadingView showCircleView:vc.view];
            break;
        case 1:
            //加载竖线动画
            [ZYLoadingView showLineView:vc.view];
            break;
        case 2:
            //加载圆点动画
            [ZYLoadingView showDotView:vc.view];
            break;
        case 3:
            //加载圆圈动画
            [ZYLoadingView showCircleJoinView:vc.view];
            break;
        case 4:
            //加载闪烁动画
            [ZYLoadingView showTwinkleView:vc.view withTime:0.1];
            break;
        case 5:
            //加载旋转动画
            [ZYLoadingView showRotateleView:vc.view withTime:1.0];
            break;
          
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
