//
//  HZChatViewController+ReceiveMessage.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/7.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class HZChatMessageModel;
@interface HZChatViewController (ReceiveMessage)

- (void)receivedMessageModel:(HZChatMessageModel *)messageModel;

@end

NS_ASSUME_NONNULL_END
