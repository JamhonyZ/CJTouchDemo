//
//  AppDelegate.m
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIViewController+Dealloc.h"
#import "SearchController.h"
#import "PublishController.h"
#import "MsgController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置跟控制器
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = mainNav;
    [self.window makeKeyAndVisible];
    

#ifdef __IPHONE_9_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
        [self creat3DTouchIcon];

        UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
        if (shortcutItem) {
            
            if([shortcutItem.type isEqualToString:@"touch_cj_share"]) {
                //分享(系统默认的底部分享栏)
                NSArray *arr = @[@"hello 3D Touch"];
                UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
                [self.window.rootViewController presentViewController:vc animated:YES completion:^{
                }];
            } else if ([shortcutItem.type isEqualToString:@"touch_cj_publish"]) {
                //进入发布界面
                if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
                    
                    UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
                    
                    [currentVC.navigationController pushViewController:[PublishController new] animated:YES];
                }
                
            } else if ([shortcutItem.type isEqualToString:@"touch_cj_search"]) {
                //搜索界面
                if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
                    
                    UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
                    
                    [currentVC.navigationController pushViewController:[SearchController new] animated:YES];
                }
            } else if ([shortcutItem.localizedTitle isEqualToString:@"消息"]) {
                
                NSLog(@"------%@-----",shortcutItem.userInfo);
                //消息界面
                if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
                    
                    UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
                    
                    [currentVC.navigationController pushViewController:[MsgController new] animated:YES];
                }
                
            }
            
            return NO;
        }

    }
    
#endif

    return YES;
}

- (void)creat3DTouchIcon {
    /**
     UIApplicationShortcutIconTypeCompose,//编辑的图标
     UIApplicationShortcutIconTypePlay,//播放图标
     UIApplicationShortcutIconTypePause,//暂停图标
     UIApplicationShortcutIconTypeAdd,//添加图标
     UIApplicationShortcutIconTypeLocation,//定位图标
     UIApplicationShortcutIconTypeSearch,//搜索图标
     UIApplicationShortcutIconTypeShare//分享图标
     */
    
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon0 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    //创建自定义图标的icon
    //    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"发布.png"];
    
    //创建快捷选项
    UIApplicationShortcutItem * item0 = [[UIApplicationShortcutItem alloc]initWithType:@"touch_cj_publish" localizedTitle:@"发布" localizedSubtitle:@"朋友圈" icon:icon0 userInfo:nil];
    
    //创建快捷选项
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc]initWithType:@"touch_cj_msg" localizedTitle:@"消息" localizedSubtitle:nil icon:icon1 userInfo:@{@"cj_key":@"cj_value"}];
    
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item0,item1];
}

//如果app在后台，通过快捷选项标签进入app，则调用该方法，如果app不在后台已杀死，则处理通过快捷选项标签进入app的逻辑在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    if([shortcutItem.type isEqualToString:@"touch_cj_share"]) {
        //分享
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    } else if ([shortcutItem.type isEqualToString:@"touch_cj_publish"]) {
        //进入发布界面
        if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
            
            UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
            
            [currentVC.navigationController pushViewController:[PublishController new] animated:YES];
        }

        
    } else if ([shortcutItem.type isEqualToString:@"touch_cj_search"]) {
        //搜索界面
        if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
            
            UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
            
            [currentVC.navigationController pushViewController:[SearchController new] animated:YES];
        }
    } else if ([shortcutItem.type isEqualToString:@"touch_cj_msg"]) {
        //消息界面
        if ([[UIViewController cjCurrent_viewController] isKindOfClass:NSClassFromString(@"UIViewController")]) {
            
            UIViewController *currentVC = (UIViewController *)[UIViewController cjCurrent_viewController];
            
            [currentVC.navigationController pushViewController:[MsgController new] animated:YES];
        }
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
