//
//  MsgCell.m
//  CJTouchDemo
//
//  Created by 创建zzh on 2017/7/6.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "MsgCell.h"

@implementation MsgModel

@end

@interface MsgCell ()

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UIView *readTag;

@property (nonatomic, strong)UIButton *editLogoBtn;

@end


@implementation MsgCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self creatView];
    }
    return self;
}


#pragma mark -- View
- (void)creatView {
    
    [self.contentView addSubview:self.editLogoBtn];
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.readTag];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //找出系统的删除按钮，重新赋值
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            subView.backgroundColor = [UIColor whiteColor];
            UIView *view = ((UIView *)[subView.subviews firstObject]);
            view.backgroundColor = [UIColor whiteColor];
            for (UIView *insideView in subView.subviews) {
                if ([insideView isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)insideView;
                    btn.backgroundColor = [UIColor whiteColor];
//                    btn.titleLabel.text = nil;
//                    btn.titleLabel.textColor = [UIColor clearColor];
                    UIImage *image = [UIImage imageNamed:@"msg_delete_icon"];
                    [btn setImage:image forState:UIControlStateNormal];
                    btn.imageView.contentMode = UIViewContentModeCenter;
                    
                }
            }
            
        }
    }
}

#pragma mark -- Set
- (void)setModel:(MsgModel *)model {
    
    _model = model;
    
    self.titleLabel.text = _model.msg_title;
    
    self.contentLabel.text = _model.msg_content;
    
    self.readTag.hidden = [_model.isRead isEqualToString:@"1"];
    
    CGFloat left = [_model.isEdit isEqualToString:@"1"] ? 70 : 12;
    _bgView.frame = CGRectMake(left, 0, kBgWidth, 70);
    
    _editLogoBtn.selected = [_model.isEditChoose isEqualToString:@"1"];
}
- (void)setPreviewingDelegate:(id<UIViewControllerPreviewingDelegate>)previewingDelegate{
    // 这里设置代理,需要控制好设置(registerForPreviewingWithDelegate)的次数,确保每个cell都有register就可以,但不要重复(若大量registerForPreviewingWithDelegate 会造成滑动失控)
    if (!_previewingDelegate){
        _previewingDelegate = previewingDelegate;
        UIViewController *controller = (UIViewController *)previewingDelegate;
        //注册代理 很重要（该方法是 控制器的方法）
        if (controller.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [controller registerForPreviewingWithDelegate:previewingDelegate sourceView:self.contentView];
        }
        
    }
    
}

#pragma mark -- LazyLoad
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kBgWidth, 70)];
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = UIColorHex(0x26A7E8);
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.frame = CGRectMake(10, 13, kBgWidth-7-9-12,  [UIFont systemFontOfSize:15].pointSize);
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font =  [UIFont systemFontOfSize:14];
        _contentLabel.frame = CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+9, CGRectGetWidth(_titleLabel.frame),  [UIFont systemFontOfSize:14].pointSize);
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

- (UIView *)readTag {
    if (!_readTag) {
        _readTag = [UIView new];
        _readTag.backgroundColor = [UIColor redColor];
        _readTag.frame = CGRectMake(5, 5, 8,8);
        _readTag.layer.cornerRadius = 4;
        _readTag.layer.masksToBounds = YES;
    }
    return _readTag;
}
- (UIButton *)editLogoBtn {
    if (!_editLogoBtn) {
        _editLogoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editLogoBtn.frame = CGRectMake(0,0 , 70, 70);
        [_editLogoBtn setImage:[UIImage imageNamed:@"msgEdit_normal"] forState:UIControlStateNormal];
        [_editLogoBtn setImage:[UIImage imageNamed:@"msgEdit_select"] forState:UIControlStateSelected];
        _editLogoBtn.imageView.contentMode = UIViewContentModeCenter;
        [_editLogoBtn addTarget:self action:@selector(clickEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editLogoBtn;
}
- (void)clickEditAction:(UIButton *)button {
    button.selected = !button.selected;
    _model.isEditChoose = button.selected ? @"1" : @"0";
    if (self.clickEditBlock) {
        self.clickEditBlock();
    }
}
@end
