//
//  MsgCell.h
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define kBgWidth (KScreenWidth-2*12)

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf

@interface MsgModel : NSObject

@property (nonatomic, copy)NSString *msg_title;

@property (nonatomic, copy)NSString *msg_content;

//是否已读
@property (nonatomic, copy)NSString *isRead;
//是否为编辑状态
@property (nonatomic, copy)NSString *isEdit;
//是否为编辑状态选中
@property (nonatomic, copy)NSString *isEditChoose;
//是否可删除
@property (nonatomic, copy)NSString *isCanDelete;

@end


@interface MsgCell : UITableViewCell

//编辑状态点击
@property (nonatomic, copy)void(^clickEditBlock)();

@property (nonatomic, strong)MsgModel *model;
/**
 *  设置3dtouch代理
 */
@property (nonatomic, weak) id<UIViewControllerPreviewingDelegate> previewingDelegate;

@end
