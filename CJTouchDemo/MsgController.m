//
//  MsgController.m
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "MsgController.h"
#import "SearchController.h"
#import "MsgCell.h"
#import "UIView+Frame.h"
#import "MsgEditBottomView.h"
#import "UIViewController+Dealloc.h"
@interface MsgController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tbView;

@property (nonatomic, strong)NSMutableArray *modelArr;

@property (nonatomic, strong)MsgEditBottomView *editView;

@end

@implementation MsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorHex(0x26A7E8);
    self.title = @"消息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.editView];
    
    self.modelArr = @[].mutableCopy;
    
    UIButton *naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    naviRightBtn.frame = CGRectMake(0, 0, 40, 30);
    [naviRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [naviRightBtn setTitle:@"取消" forState:UIControlStateSelected];
    [naviRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [naviRightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:naviRightBtn];
    self.navigationItem.rightBarButtonItem = item;

    
    [self loadMsgData];
}
- (void)editAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self changeStateIfEdit:btn.selected];
}
- (void)changeStateIfEdit:(BOOL)ifEdit {
    for (MsgModel *model in self.modelArr) {
        model.isEdit = ifEdit ? @"1":@"0";
        model.isEditChoose = @"0";
    }
    [UIView animateWithDuration:.2 animations:^{
        self.tbView.height = ifEdit ? KScreenHeight-64-kMsgEditBottomViewHeight :KScreenHeight-64;
        self.editView.top = ifEdit?self.view.bottom-kMsgEditBottomViewHeight:self.view.bottom;
    }];
    [self.tbView reloadData];
    
    [self.editView configAllChooseState:NO];
}
- (void)loadMsgData {
    
    for (int i = 0; i<10; i++) {
        MsgModel *model = [MsgModel new];
        model.msg_title = [NSString stringWithFormat:@"消息%@",@(i)];
        model.msg_content = [NSString stringWithFormat:@"内容是%@",@(i)];
        model.isCanDelete = @"1";
        model.isEdit = @"0";
        model.isRead = @"0";
        model.isEditChoose = @"0";
        [self.modelArr addObject:model];
    }
    [self.tbView reloadData];
    
}

#pragma mark -- Touch__Peek
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    if (viewControllerToCommit){
        //iOS8 新增跳转方式，会根据自身的vc持有状态 进行对应的跳转，这里实现走的是 push方式
        //http://www.jianshu.com/p/0fc3c8e83522
        [self showViewController:viewControllerToCommit sender:self];
    }
}
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    // 1.我们可以通过触控的location获取 当前点击的是第几个元素(位于collectionview)
    // 2.由于响应3dtouch事件的view是cell的contentView,我们对触控拿到的location要进行一个转换(相对于父视图来说的位置
    // 3.这里通过previewingContext中sourceView获取到触摸的view
    UIView *contentView = previewingContext.sourceView;
    // 看回"2" 中第一句话,我们要拿到这个触控的location位于tbView中的位置
    CGPoint iLocation = [contentView convertPoint:location toView:self.tbView];
    // 将 获取到的位置 通过collectionview获取indexPath
    NSIndexPath *indexPath = [self.tbView indexPathForRowAtPoint:iLocation];
    
    SearchController *vc = [[SearchController alloc] initWithMsgModel:self.modelArr[indexPath.section]];
    vc.msgDetailReadBlock = ^(MsgModel *model) {
        model.isRead = @"1";
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:[self.modelArr indexOfObject:model]];
        [self.tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    };
    vc.msgDetailDeleteBlock = ^(MsgModel *model) {
        [self.modelArr removeObject:model];
        [self.tbView reloadData];
    };
    return vc;
}


#pragma mark -- tbViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MsgCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置代理
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            cell.previewingDelegate = self;
        }
    }
    
    if (self.modelArr.count > indexPath.section) {
        cell.model = self.modelArr[indexPath.section];
    }
    
    kSelfWeak;
    cell.clickEditBlock = ^(){
        kSelfStrong;
        BOOL ifAllChoose = YES;
        for (MsgModel *model in strongSelf.modelArr) {
            if ([model.isEditChoose isEqualToString:@"0"]) {
                ifAllChoose = NO;
                break;
            }
        }
        [strongSelf.editView configAllChooseState:ifAllChoose];
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 10 : 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.modelArr.count > indexPath.section) {
        
        MsgModel *model = self.modelArr[indexPath.section];
        
        model.isRead = @"1";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:indexPath.section];
            [self.tbView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        });
        
        
        SearchController *vc = [[SearchController alloc] initWithMsgModel:self.modelArr[indexPath.section]];
        vc.msgDetailReadBlock = ^(MsgModel *model) {
            model.isRead = @"1";
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:[self.modelArr indexOfObject:model]];
            [self.tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        };
        vc.msgDetailDeleteBlock = ^(MsgModel *model) {
            [self.modelArr removeObject:model];
            [self.tbView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



#pragma mark - 左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgModel *model = self.modelArr[indexPath.section];
    return [model.isCanDelete isEqualToString:@"1"];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //模拟请求
        [self deleteRequestData:@[self.modelArr[indexPath.section]]];
    }
}

- (NSString *)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return @"      ";
    
}

#pragma mark -- Action
- (void)deleteRequestData:(NSArray *)deleteArr {
    NSIndexSet *set;
    if (deleteArr.count == 1) {
        MsgModel *chooseModel = deleteArr.lastObject;
        set = [[NSIndexSet alloc] initWithIndex:[self.modelArr indexOfObject:chooseModel]];
    }
    
    //模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self deleteSucceed];
        [self.modelArr removeObjectsInArray:deleteArr];
        if (deleteArr.count == 1) {
            [self.tbView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self.tbView reloadData];
        }
    });
}
- (void)deleteSucceed {
    NSLog(@"删除成功");
}

- (UIViewController *)viewController {
    
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}

#pragma mark -- TbView
- (UITableView *)tbView {
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
        _tbView.rowHeight = 70;
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.showsHorizontalScrollIndicator = NO;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        [_tbView registerClass:[MsgCell class] forCellReuseIdentifier:NSStringFromClass([MsgCell class])];
    }
    return _tbView;
}
- (MsgEditBottomView *)editView {
    if (!_editView) {
        _editView = [[MsgEditBottomView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, kMsgEditBottomViewHeight)];

        //全选
        kSelfWeak;
        _editView.allChooseBlcok = ^(BOOL ifChoose){
            kSelfStrong;
            for (MsgModel *model in strongSelf.modelArr) {
                model.isEditChoose = ifChoose ?@"1":@"0";
            }
            [strongSelf.tbView reloadData];
            
            if (!ifChoose) {
                ((UIButton *)strongSelf.navigationItem.rightBarButtonItem.customView).selected = NO;
                [strongSelf changeStateIfEdit:NO];
            }
        };
        //删除
        _editView.deleteBlcok = ^(){
            kSelfStrong;
            NSMutableArray *chooseArr = @[].mutableCopy;
            for (MsgModel *model in strongSelf.modelArr) {
                if ([model.isEditChoose isEqualToString:@"1"]) {
                    [chooseArr addObject:model];
                }
            }
            if (chooseArr.count>0) {
                [strongSelf deleteRequestData:chooseArr];
            }
            
            ((UIButton *)strongSelf.navigationItem.rightBarButtonItem.customView).selected = NO;
            [strongSelf changeStateIfEdit:NO];
        };
        //标记已读
        _editView.readBlcok = ^(){
            kSelfStrong;
            NSMutableArray *chooseArr = @[].mutableCopy;
            for (MsgModel *model in strongSelf.modelArr) {
                if ([model.isEditChoose isEqualToString:@"1"]) {
                    [chooseArr addObject:model];
                    //模拟请求
                    model.isRead = @"1";
                }
            }
            if (chooseArr.count>0) {
                [strongSelf.tbView reloadData];
            }
            ((UIButton *)strongSelf.navigationItem.rightBarButtonItem.customView).selected = NO;
            [strongSelf changeStateIfEdit:NO];
        };
        
    }
    return _editView;
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
