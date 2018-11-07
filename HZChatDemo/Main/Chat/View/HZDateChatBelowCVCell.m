//
//  HZDateChatBelowCVCell.m
//  ypxsq
//
//  Created by o888 on 2018/7/26.
//  Copyright © 2018年 o888. All rights reserved.
//

#import "HZDateChatBelowCVCell.h"
#import <Masonry.h>
#import "JXLayoutButton.h"

@interface HZDateChatBelowCVCell ()
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *belowView;

@property (strong, nonatomic) JXLayoutButton *imageButton;

@end

#define ImageButtonImageSizeRatio 0.8

@implementation HZDateChatBelowCVCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.contentView);
        make.size.equalTo(weakSelf.contentView).multipliedBy(ImageButtonImageSizeRatio);
        
    }];
}

- (JXLayoutButton *)imageButton {
    if (!_imageButton) {
        _imageButton = ({
            JXLayoutButton *button = [JXLayoutButton new];
            button.layoutStyle = JXLayoutButtonStyleUpImageDownTitle;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            //计算上部图片的大小
            CGFloat height = CGRectGetHeight(self.frame) * ImageButtonImageSizeRatio;
            CGFloat fontHeight = button.titleLabel.font.lineHeight;
            CGFloat imageHeight = height - fontHeight - button.midSpacing;
            CGFloat imageWidth = CGRectGetHeight(self.frame) * ImageButtonImageSizeRatio;
            
            CGFloat imageHeight_should = imageHeight<imageWidth?imageHeight:imageWidth;//得到图片的值
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
            
            //设置
            [button setImageSize:CGSizeMake(imageHeight_should, imageHeight_should)];
            
            button;
        });
    }
    
    return _imageButton;
}

- (void)buttonClicked:(UIButton *)button {
    if (self.didSelectedItem) {
        self.didSelectedItem(button);
    }
}

- (void)setItemDict:(NSDictionary *)itemDict {
    _itemDict = itemDict;
    
    [self.imageButton setImage:[UIImage imageNamed:itemDict[@"imageName"]] forState:UIControlStateNormal];
    [self.imageButton setImage:[UIImage imageNamed:itemDict[@"selectedImageName"]] forState:UIControlStateNormal];
    [self.imageButton setImage:[UIImage imageNamed:itemDict[@"selectedImageName"]] forState:UIControlStateHighlighted];
    
    [self.imageButton setTitle:itemDict[@"title"] forState:UIControlStateNormal];
}


@end
