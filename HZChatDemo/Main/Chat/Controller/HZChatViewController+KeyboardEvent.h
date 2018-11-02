//
//  HZChatViewController+KeyboardEvent.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZChatViewController (KeyboardEvent)
- (void)addKeyboardNotifications;
- (void)removeKeyboardNotifications;

@end

NS_ASSUME_NONNULL_END
