//
//  MsgEditBottomView.h
//  XJCardPro
//
//  Created by 创建zzh on 2017/6/30.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kMsgEditBottomViewHeight = 60.f;

@interface MsgEditBottomView : UIView

//全选
@property (nonatomic, copy)void(^allChooseBlcok)(BOOL ifChoose);
//删除
@property (nonatomic, copy)void(^deleteBlcok)();
//标记已读
@property (nonatomic, copy)void(^readBlcok)();

- (void)configAllChooseState:(BOOL)ifChoose;

- (void)changeEditIfShowDelete:(BOOL)ifShowDelete;

@end
