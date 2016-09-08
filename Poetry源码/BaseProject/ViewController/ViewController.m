//
//  ViewController.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//


#import "ViewController.h"
#import "KindViewModel.h"
#import "KindIntroViewController.h"
#import "ShiListViewController.h"
#import "SearchPoetryViewModel.h"
#import "PoetryDetailViewController.h"
#import "PoetryKindCell.h"

#import <objc/runtime.h>

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, PoetryKindCellDelegate>
@property(nonatomic,strong) SearchPoetryViewModel *searchPoetryVM;
@property(nonatomic,strong) KindViewModel *kindVM;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong) IBOutlet UICollectionView *collectionView;
@end
@implementation ViewController
{
    BOOL _editing;
}
- (SearchPoetryViewModel *)searchPoetryVM{
    if (!_searchPoetryVM) {
        _searchPoetryVM = [SearchPoetryViewModel new];
    }
    return _searchPoetryVM;
}

- (KindViewModel *)kindVM{
    if (!_kindVM) {
        _kindVM = [KindViewModel new];
    }
    return _kindVM;
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.kindVM.kinds.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_editing) {
        ShiListViewController *vc=[[ShiListViewController alloc] initWithKind:[self.kindVM titleForRow:indexPath.row]];
        vc.introKind = [self.kindVM detailForRow:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    340 162
    CGFloat width = (kWindowW - 2 * 15 - 5) /2 ;
    return CGSizeMake(width, width * 162 / 340);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PoetryKindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delIV.hidden = !_editing;
    cell.delegate = self;
    KindModel *model = self.kindVM.kinds[indexPath.row];
    cell.bgIV.image = [UIImage imageNamed:model.kind];
    return cell;
}

- (void)removePoetryKindCell:(PoetryKindCell *)poetryKindCell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:poetryKindCell];
    [[UIAlertView bk_showAlertViewWithTitle:[self.kindVM titleForRow:indexPath.row] message:@"确认要删除此诗集吗?这个操作无法恢复!" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) { //确定按钮
            if ([self.kindVM removeKindForRow:indexPath.row]) {
                [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
            }
        }
    }] show];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return self.searchPoetryVM.rowNumber;
}
kRemoveCellSeparator
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //如果是搜索界面
    cell.textLabel.text =[self.searchPoetryVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.searchPoetryVM authorForRow:indexPath.row];
    cell.textLabel.textColor = [UIColor colorFromHexCode:@"7f6d54"];
    cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"907b5e"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PoetryDetailViewController *vc = [[PoetryDetailViewController alloc] initWithShi:[self.searchPoetryVM shiForRow:indexPath.row] intro:[self.searchPoetryVM shiIntroForRow:indexPath.row]];
    vc.title = [self.searchPoetryVM titleForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Factory addBarButtonItem:BarButtonItemTypeRight toVC:self withTitle:@"编辑" completionHandle:^(UIBarButtonItem *sender) {
        _editing = !_editing;
        sender.title = _editing?@"编辑":@"完成";
        [_collectionView reloadData];
    }];
    [self configSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBar
//搜索栏内容有更改时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchPoetryVM.searchStr = searchText;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)configSearchBar{
    
    NSArray *subs = _searchBar.subviews.firstObject.subviews;
    [subs.firstObject removeFromSuperview];
    UITextField *tf = subs.lastObject;
    tf.background = [UIImage imageNamed:@"圆角矩形-1"];
    tf.borderStyle = 0;
    //向搜索列表中注册cell
    [self.searchDisplayController.searchResultsTableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    self.searchDisplayController.searchResultsTableView.tableFooterView = [UIView new];
    self.searchDisplayController.searchResultsTableView.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

@end






