//
//  MsgEditBottomView.m
//  XJCardPro
//
//  Created by 创建zzh on 2017/6/30.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "MsgEditBottomView.h"
#import "UIView+Frame.h"
#import "MsgCell.h"
#import "UIButton+Block.h"
@interface MsgEditBottomView ()

@end

@implementation MsgEditBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}

#pragma mark -- View
- (void)configAllChooseState:(BOOL)ifChoose {
    UIButton *btn = (UIButton *)[self viewWithTag:100];
    btn.selected = ifChoose;
}
- (void)changeEditIfShowDelete:(BOOL)ifShowDelete {
    UIButton *deleteBtn = (UIButton *)[self viewWithTag:101];
    UIButton *readBtn = (UIButton *)[self viewWithTag:102];
    deleteBtn.hidden = !ifShowDelete;
    readBtn.right = ifShowDelete ? self.width-100-12-12:self.width-12;
}

- (void)creatView {

    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake(0, 0, 44+40, kMsgEditBottomViewHeight);
    [chooseBtn setImage:[UIImage imageNamed:@"msgEdit_normal"] forState:UIControlStateNormal];
    [chooseBtn setImage:[UIImage imageNamed:@"msgEdit_select"] forState:UIControlStateSelected];
    [chooseBtn setTitle:@"全选" forState:UIControlStateNormal];
    [chooseBtn setTitle:@"取消" forState:UIControlStateSelected];

    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    chooseBtn.tag = 100;
    [chooseBtn setTitleColor:UIColorHex(0x666666) forState:UIControlStateNormal];
    [self addSubview:chooseBtn];
    
    
    [chooseBtn cj_clickActionBlock:^(UIButton *button) {

        button.selected = !button.selected;
        if (self.allChooseBlcok) {
            self.allChooseBlcok(button.selected);
        }
    }];
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(self.width-100-12, 8, 100, 45);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = UIColorHex(0x00B38A);
    deleteBtn.tag = 101;
    
    [self addSubview:deleteBtn];
    
    [deleteBtn cj_clickActionBlock:^(UIButton *button) {
       
        if (self.deleteBlcok) {
            self.deleteBlcok();
        }
    }];
    
    UIButton *readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readBtn.frame = CGRectMake(deleteBtn.left-100-12, 8, 100, 45);
    [readBtn setTitle:@"标为已读" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    readBtn.tag = 102;
    [readBtn setTitleColor:UIColorHex(0x00B38A) forState:UIControlStateNormal];
    
    readBtn.layer.borderColor = UIColorHex(0x00B38A).CGColor;
    readBtn.layer.borderWidth = 1;
    readBtn.layer.masksToBounds = YES;
    readBtn.layer.cornerRadius = 3;
    [self addSubview:readBtn];
    
    [readBtn cj_clickActionBlock:^(UIButton *button) {
       
        if (self.readBlcok) {
            self.readBlcok();
        }
    }];
}


@end
