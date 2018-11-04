//
//  HZChatMessageTVCell.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZChatBaseMessageTVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZChatMessageTVCell : HZChatBaseMessageTVCell

@property (strong, nonatomic) UIButton  *avatarButton;
@property (strong, nonatomic) UILabel   *dateLabel;
@property (strong, nonatomic) UIView    *mediaContentView;

@property (assign, nonatomic, readonly) CGFloat safeMediaContentMarginToBorder;

@end

NS_ASSUME_NONNULL_END
