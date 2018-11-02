//
//  HZChatBaseMessageTVCell.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatBaseMessageTVCell.h"

@implementation HZChatBaseMessageTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
