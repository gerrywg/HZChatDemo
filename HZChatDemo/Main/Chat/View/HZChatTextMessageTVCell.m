//
//  HZChatTextMessageTVCell.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatTextMessageTVCell.h"

@interface HZChatTextMessageTVCell ()

@property (strong, nonatomic) UIButton  *mediaContentButton;
@property (strong, nonatomic) UILabel   *textMessageLabel;

@end

@implementation HZChatTextMessageTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        HZChatCellContentType contentType = [self.chatCellContentTypeDelegate hz_chatCellContentTypeWithReuseIdentifier:reuseIdentifier];
        
        [self setupUIWithHZChatCellContentType:contentType];
    }
    
    return self;
}

- (void)setupUIWithHZChatCellContentType:(HZChatCellContentType)contentType {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
