# CJTouchDemo
学习
内部分享学习，本demo提供了iOS9（硬件6s后设备）3DTouch功能的使用，分别为应用icon的重力长按，控件的touch.force重力系数，peek&pop弹窗。

第一部分学习：

详见info.plist文件设置（UIApplicationShortcutItems）和 AppDelegate

第二部分学习:

详见ViewController 关于 响应者链代理里的代码

第三部分学习:

参考Msg类

step1:注册代理控制器[controller registerForPreviewingWithDelegate:previewingDelegate sourceView:self.contentView];
step2:控制器实现响应的内容

//实现代理
UIViewControllerPreviewingDelegate
//返回需要peek的控制器
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
//对上面控制器的重力释放操作
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
step3：peek出来的控制器上滑内容
//类似actionSheet的选择框
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
