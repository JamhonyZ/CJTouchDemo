//
//  ViewController.m
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "ViewController.h"
#import "SearchController.h"
#import "PublishController.h"
#import "MsgController.h"
@interface ViewController ()<UIViewControllerPreviewingDelegate>
@property (nonatomic, strong)UILabel *showLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSArray *titles = @[@"跳转消息",@"跳转发布"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jumpBtn.frame = CGRectMake(50+(50+100)*i, 100, 100, 40);
        [jumpBtn setTitle:titles[i] forState:UIControlStateNormal];
        [jumpBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        jumpBtn.backgroundColor = [UIColor grayColor];
        jumpBtn.tag = 100+i;
        [jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:jumpBtn];
    }
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, CGRectGetWidth(self.view.frame)-100, 40)];
    tipLabel.text = @"长按我,重重的";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor orangeColor];
    tipLabel.layer.borderColor = [UIColor greenColor].CGColor;
    tipLabel.layer.borderWidth = 1;
    tipLabel.userInteractionEnabled = YES;
    tipLabel.tag = 105;
    [self.view addSubview:tipLabel];
    
    
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetHeight(self.view.frame)-100, CGRectGetWidth(self.view.frame)-200, 20)];
    _showLabel.text = @"0";
    _showLabel.textColor = [UIColor orangeColor];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.layer.borderColor = [UIColor greenColor].CGColor;
    _showLabel.layer.borderWidth = 1;
    _showLabel.userInteractionEnabled = YES;
    [self.view addSubview:_showLabel];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"Began压力 ＝ %f",touch.force);
        _showLabel.text = [NSString stringWithFormat:@"压力%f",touch.force];
    }
}

//按住移动or压力值改变时的回调
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"move压力 ＝ %f",touch.force);
        _showLabel.text = [NSString stringWithFormat:@"压力%f",touch.force];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"End压力 ＝ %f",touch.force);
        _showLabel.text = [NSString stringWithFormat:@"压力%f",touch.force];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"Cancel压力 ＝ %f",touch.force);
        NSLog(@"压力所在view的tag ＝ %li",touch.view.tag);
        _showLabel.text = [NSString stringWithFormat:@"压力%f",touch.force];
    }
    
}
#pragma mark -- 跳转
- (void)jumpAction:(UIButton *)btn {
    switch (btn.tag - 100) {
        case 0: {
            [self.navigationController pushViewController:[MsgController new] animated:YES];
        }
            break;
        case 1: {
            [self.navigationController pushViewController:[PublishController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
