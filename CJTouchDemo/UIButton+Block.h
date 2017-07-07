//
//  UIButton+Block.h
//  EasyGo
//
//  Created by ZZH on 16/4/12.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)

/**
 *  @brief  替换系统的target-action 机制为block回调机制，
 *          这样方便数据的存取，不需要在方法外做额外的操作，直接写在button申明的地方
 *
 *  @param clickCallBack 回调block
 */
/**

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];  
    @weakify(self);
    [btn cj_clickActionBlock:^(UIButton *button) {
        @strongify(self);
        [self doAction];
    }];
 
 */
- (void)cj_clickActionBlock:(void(^)(UIButton *button))clickCallBack;

@end
