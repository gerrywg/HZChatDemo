//
//  HZChatMessageTVCell.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatMessageTVCell.h"
#import "HZChatManager.h"
#import "HZChatConstants.h"
#import <Masonry.h>

@interface HZChatMessageTVCell ()

@property (assign, nonatomic) HZChatCellSide cellSide;

@end

@implementation HZChatMessageTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //计算安全距离
        _safeMediaContentMarginToBorder = rightPadding + innerPadding + bubbleArrowWidth;
        
        //设置UI
        [self setupUI1];
    }
    
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
}

- (void)updateConstraints {
    
    HZChatCellSide side = [self.hz_delegate hz_chatCellSideWithReuseIdentifier:self.reuseIdentifier];
    self.cellSide = side;
    
    [self updateConstraintsWithSide:self.cellSide];
    
    [super updateConstraints];
}

- (void)setupUI1 {
    
    [self.contentView addSubview:self.avatarButton];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.mediaContentView];
}

- (void)updateConstraintsWithSide: (HZChatCellSide)side {
    
    switch (side) {
        case HZChatCellSideOtherSide:
            //聊天对方
            [self setupUIOtherSide];
            break;
        case HZChatCellSideMySide:
            //聊天自己
            [self setupUIMySide];
            break;
            
        default:
            break;
    }
}

- (void)setupUIOtherSide {
    
    __weak typeof (self) weakSelf = self;
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).with.offset(topPadding);
    }];
    
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(leftPadding);
        make.top.equalTo(weakSelf.contentView).with.offset(topPadding);
        make.width.equalTo(@(avatarWidth));
        make.height.equalTo(@(avatarHeight));
    }];

    [self.mediaContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.avatarButton.mas_right).with.offset(innerPadding + bubbleArrowWidth);
        make.top.equalTo(weakSelf.avatarButton).with.offset(innerPadding);
        make.right.lessThanOrEqualTo(weakSelf.contentView).with.offset(-weakSelf.safeMediaContentMarginToBorder);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-bottomPadding);
    }];
}

- (void)setupUIMySide {
    
    __weak typeof (self) weakSelf = self;
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).with.offset(topPadding);
    }];
    
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-rightPadding);
        make.top.equalTo(weakSelf.contentView).with.offset(topPadding);
        make.width.equalTo(@(avatarWidth));
        make.height.equalTo(@(avatarHeight));
    }];
    
    [self.mediaContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.avatarButton.mas_left).with.offset(innerPadding + bubbleArrowWidth);
        make.top.equalTo(weakSelf.avatarButton).with.offset(innerPadding);
        make.left.greaterThanOrEqualTo(weakSelf.contentView).with.offset(weakSelf.safeMediaContentMarginToBorder);
        make.bottom.equalTo(weakSelf.contentView).with.offset(- bottomPadding);
    }];
}


- (UIButton *)avatarButton {
    
    if (!_avatarButton) {
        _avatarButton = ({
            UIButton *button = [UIButton new];
            
            button;
        });
    }
    return _avatarButton;
}

- (UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = ({
            
            UILabel *label = [UILabel new];
            
            label;
        });
    }
    
    return _dateLabel;
}

- (UIView *)mediaContentView {
    
    if (!_mediaContentView) {
        
        _mediaContentView = ({
            UIView *view = [UIView new];
            
            view;
        });
    }
    
    return _mediaContentView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
