//
//  HZChatBaseMessageTVCell.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZChatEnum.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HZChatBaseMessageTVCellDelegate <NSObject>

- (HZChatCellSide) hz_chatCellSideWithReuseIdentifier:(NSString *)reuseIdentifier;

//- (HZChatContentType) hz_chatCellContentTypeWithReuseIdentifier:(NSString *)reuseIdentifier;

@optional

- (NSString *) hz_customChatCellClassNameWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@class HZChatMessageModel;
@interface HZChatBaseMessageTVCell : UITableViewCell

@property (weak, nonatomic) id <HZChatBaseMessageTVCellDelegate> hz_delegate;

@property (strong, nonatomic) HZChatMessageModel *messageModel;

@end

NS_ASSUME_NONNULL_END
