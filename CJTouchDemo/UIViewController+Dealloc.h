//
//  UIViewController+Dealloc.h
//  WenLingCitizenCard
//
//  Created by 创建zzh on 2017/3/7.
//  Copyright © 2017年 zhusf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Dealloc)

/**
 *  获取根控制器
 *
 *  @return <#return value description#>
 */
+ (__kindof UIViewController *)rootViewController;

///该vc的navigationController
- (__kindof UINavigationController*)cjCurrent_navigationController;

//当前控制器
+ (UIViewController*)cjCurrent_viewController;



@end
