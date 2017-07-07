//
//  UIViewController+Dealloc.m
//  WenLingCitizenCard
//
//  Created by 创建zzh on 2017/3/7.
//  Copyright © 2017年 zhusf. All rights reserved.
//

#import "UIViewController+Dealloc.h"
#import <objc/runtime.h>
@implementation UIViewController (Dealloc)

#pragma mark - 当类第一次加载到内存的时候会调用这个方法，它要比main.m方法先执行

+(void)load{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    
    Method method2 = class_getInstanceMethod([self class], @selector(lca_dealloc));
    
    method_exchangeImplementations(method1, method2);
    
}

#pragma mark - 自定义的dealloc方法

- (void)lca_dealloc{
    
    NSLog(@"---------------%@已被销毁！！！---------------", NSStringFromClass(self.class));
    
    //执行系统的dealloc方法，不会发生死循环，因为它会执行系统的dealloc方法
    
    //我们可能会在系统的dealloc方法中执行一些释放操作，所以在自定义的dealloc方法中也要执行系统的
    
    [self lca_dealloc];
    
}
/************************************/

#pragma mark -- 当前控制器的导航控制器

+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (UIViewController *)rootViewController {
    return self.applicationDelegate.window.rootViewController;
}

- (UINavigationController*)cjCurrent_navigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = [((UITabBarController*)self).selectedViewController cjCurrent_navigationController];
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}

#pragma mark -- 获取当前控制器
+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

+ (UIViewController*)cjCurrent_viewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}





@end
