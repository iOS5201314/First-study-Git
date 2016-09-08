//
//  ShiListViewController.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "ShiListViewController.h"
#import "PoetryViewModel.h"
#import "KindIntroViewController.h"

@implementation PoetryCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
@end

#import "PoetryDetailViewController.h"

@interface ShiListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) PoetryViewModel *poetryVM;
@end
@implementation ShiListViewController
- (id)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}
- (PoetryViewModel *)poetryVM{
    if (!_poetryVM) {
        _poetryVM=[[PoetryViewModel alloc] initWithKind:_kind];
    }
    return _poetryVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [Factory addBackItemToVC:self];
    self.title = _kind;
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    if (_introKind.length > 0) {
        [Factory addBarButtonItem:BarButtonItemTypeRight toVC:self withTitle:@"诗集详情" completionHandle:^(id sender) {
            KindIntroViewController *vc = [KindIntroViewController new];
            vc.introKind = _introKind;
            vc.title = self.title;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }

}
#pragma mark - UITableView
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == 1) {
        [[UIAlertView bk_showAlertViewWithTitle:[self.poetryVM titleForRow:indexPath.row] message:@"确认要删除此诗吗？此操作不可恢复!!" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if ([self.poetryVM removePoetryForRow:indexPath.row]) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }] show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.poetryVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.poetryVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.poetryVM authorForRow:indexPath.row];
    cell.accessoryType = 1; //→
    cell.textLabel.textColor = [UIColor colorFromHexCode:@"7f6d54"];
    cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"907b5e"];
    return cell;
}
kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PoetryDetailViewController *vc=[[PoetryDetailViewController alloc] initWithShi:[self.poetryVM shiForRow:indexPath.row] intro:[self.poetryVM shiIntroForRow:indexPath.row]];
    vc.title = [self.poetryVM titleForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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

@end
