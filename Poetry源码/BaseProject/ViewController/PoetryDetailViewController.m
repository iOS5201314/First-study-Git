//
//  PoetryDetailViewController.m
//  BaseProject
//
//  Created by liwendong on 16/7/21.
//  Copyright © 2016年 lwd. All rights reserved.
//

#import "PoetryDetailViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface PoetryDetailCell:UITableViewCell
@property(nonatomic, strong) UILabel *label;
@end
@implementation PoetryDetailCell
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:18];
        //自动换行
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorFromHexCode:@"534430"];
    }
    return _label;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}
@end

//作业：右上角添加朗读诗词按钮
@interface PoetryDetailViewController ()<UITableViewDelegate, UITableViewDataSource, AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) UITableView *tableView;

//语音功能
@property(nonatomic,strong) AVSpeechSynthesizer *spe;
//右上角朗读按钮
@property(nonatomic,strong) UIBarButtonItem *readItem;
@end
@implementation PoetryDetailViewController

- (UIBarButtonItem *)readItem{
    if (!_readItem) {
        _readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.spe.speaking) {
                [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            AVSpeechUtterance *utt =[AVSpeechUtterance speechUtteranceWithString:[_shi stringByAppendingString:_shiIntro]];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
            [self.spe speakUtterance:utt];
            
        }];
    }
    return _readItem;
}

- (AVSpeechSynthesizer *)spe{
    if (!_spe) {
        _spe = [AVSpeechSynthesizer new];
        _spe.delegate = self;
    }
    return _spe;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (id)initWithShi:(NSString *)shi intro:(NSString *)shiIntro{
    if (self = [super init]) {
        _shi = shi;
        _shiIntro = shiIntro;
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView=[UIView new];
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PoetryDetailCell class] forCellReuseIdentifier:@"DetailCell"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.hidden = NO;
    [Factory addBackItemToVC:self];
    self.navigationItem.rightBarButtonItem = self.readItem;
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    headerView.textLabel.text = @[@"诗词赏析", @"注解"][section];
    /** 这里必须使用KVO来监听颜色修改, 因为系统会自动修改字体颜色 */
    UIColor *clo = [UIColor colorFromHexCode:@"534430"];
    [headerView bk_addObserverForKeyPath:@"textLabel.textColor" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        
        id obj1 = change[@"new"];
        if (obj1 != clo) {
            headerView.textLabel.textColor = clo;
        }
        NSLog(@"change %@", change);
    }];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    headerView.backgroundView = bgView;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoetryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.label.text = @[_shi, _shiIntro][indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//iOS7新加入的协议
/*
 面试问题:如何提高tableView的加载速度?
 协议：HeightForRow和cellForRow 执行顺序？
 在执行cellForRow之前，table中如果有100行，那么会执行100次HeightForRow，计算出table的内容总高度，为了让右侧滑动条显示准确
 当实现estimatedHeightForRow协议以后，HeightForRow方法只会当cell加载时，才运行。
 */
//下方协议，也是通过autoLayout实现cell高度自动匹配的关键点
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"停止";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
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











