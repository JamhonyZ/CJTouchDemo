//
//  SearchController.m
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController
- (instancetype)initWithMsgModel:(MsgModel *)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title =  _model ?_model.msg_title : @"搜索界面";
}


#pragma mark -- 实现pop底部弹窗功能键
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"标为已读" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if (self.msgDetailReadBlock) {
            self.msgDetailReadBlock(_model);
        }
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if (self.msgDetailDeleteBlock) {
            self.msgDetailDeleteBlock(_model);
        }
    }];
    
    return @[action1, action2];
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
