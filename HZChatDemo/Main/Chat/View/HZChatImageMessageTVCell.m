//
//  HZChatImageMessageTVCell.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/4.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatImageMessageTVCell.h"
#import "HZChatConstants.h"
#import "HZUIMacro.h"
#import <Masonry.h>
#import "HZChatMessageModel.h"
#import <UIImageView+WebCache.h>

@implementation HZChatImageMessageTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints{
    
    __weak typeof (self) weakSelf = self;
    
    CGFloat imageViewWidth   = KSCREEN_WIDTH/2.0 - self.safeMediaContentMarginToBorder;
    CGFloat imageViewHeight  = imageViewWidth;
    
    if (self.messageModel) {
        NSDictionary *userInfo = self.messageModel.hz_userInfo;
        
        if (userInfo[@"imageWidth"]) {
            CGFloat imageWidth  = [userInfo[@"imageWidth"] doubleValue];
            CGFloat imageHeight = [userInfo[@"imageHeight"] doubleValue];
            
            if (imageWidth>imageHeight) {
                
                imageViewHeight = imageViewWidth/imageWidth * imageHeight;
            }else {
                
                imageViewWidth = imageViewHeight/imageHeight * imageWidth;
            }
        }
    }
    
    [self.hz_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.mediaContentView);
        
        make.width.equalTo(@(imageViewWidth));
        make.height.equalTo(@(imageViewHeight));
    }];
    
    [super updateConstraints];
}

- (void)setupUI {
    
    [self.mediaContentView addSubview:self.hz_imageView];
    
    self.bubbleView.hz_fillColor = [UIColor clearColor];
    self.bubbleView.chatArrowBorderColor = [UIColor clearColor];
    self.bubbleView.chatArrowBorderWidth = 0.0;
}

- (UIImageView *)hz_imageView {
    
    if (!_hz_imageView) {
        _hz_imageView = ({
            
            UIImageView *imageView = [UIImageView new];
            
            imageView.layer.cornerRadius  = mediaViewCornerRadius;
            imageView.layer.masksToBounds = YES;
            
            imageView;
        });
    }
    
    return _hz_imageView;
}

- (void)setMessageModel:(HZChatMessageModel *)messageModel {
    
    [super setMessageModel:messageModel];
    
    if (messageModel.hz_userInfo) {
        
        [self.hz_imageView setImage:messageModel.hz_userInfo[@"image"]];
        [self setNeedsUpdateConstraints];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
