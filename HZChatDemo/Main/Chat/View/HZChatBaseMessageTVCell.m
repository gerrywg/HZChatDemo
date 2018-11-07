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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
