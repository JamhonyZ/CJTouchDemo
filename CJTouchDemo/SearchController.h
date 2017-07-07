//
//  SearchController.h
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCell.h"
@interface SearchController : UIViewController

- (instancetype)initWithMsgModel:(MsgModel *)model;

@property (nonatomic, strong)MsgModel *model;

//已读
@property (nonatomic, copy)void(^msgDetailReadBlock)(MsgModel *model);

//删除
@property (nonatomic, copy)void(^msgDetailDeleteBlock)(MsgModel *model);

@end
