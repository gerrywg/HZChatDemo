//
//  HZChatTextMessageTVCell.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/4.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatTextMessageTVCell.h"
#import <Masonry.h>
#import "HZChatConstants.h"
#import "HZChatMessageModel.h"
#import "HZUIMacro.h"

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

- (TTTAttributedLabel *)textMessageLabel {
    
    if (!_textMessageLabel) {
        _textMessageLabel = ({
            
            TTTAttributedLabel *label = [TTTAttributedLabel new];
            
            //[label setBackgroundColor:[UIColor greenColor]];
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setNumberOfLines:0];
            
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            
            [label setTextInsets:UIEdgeInsetsMake(textMarginToBorder, textMarginToBorder, textMarginToBorder, textMarginToBorder)];
            
            //[label setLayoutMargins:UIEdgeInsetsMake(textMarginToBorder, textMarginToBorder, textMarginToBorder, textMarginToBorder)];
            
            label;
        });
    }
    
    return _textMessageLabel;
}

- (void)setMessageModel:(HZChatMessageModel *)messageModel {
    
    [super setMessageModel:messageModel];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:messageModel.message];
    
    text.yy_paragraphSpacing    = textParagraphSpacing;
    text.yy_lineSpacing         = textLineSpacing;
    text.yy_font                = [UIFont systemFontOfSize:15];
    
    self.textMessageLabel.attributedText = text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
