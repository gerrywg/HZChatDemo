//
//  HZChatTextMessageTVCell.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/4.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatTextMessageTVCell.h"
#import <Masonry.h>

@implementation HZChatTextMessageTVCell

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
    
    [self.textMessageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(weakSelf.mediaContentView);
    }];
    
    [super updateConstraints];
}

- (void)setupUI {
    
    [self.mediaContentView addSubview:self.textMessageLabel];
}

- (UILabel *)textMessageLabel {
    
    if (!_textMessageLabel) {
        _textMessageLabel = ({
            
            UILabel *label = [UILabel new];
            [label setNumberOfLines:0];
            
            label;
        });
    }
    
    return _textMessageLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
