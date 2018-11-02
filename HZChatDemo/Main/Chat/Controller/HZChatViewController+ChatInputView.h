//
//  HZChatViewController+ChatInputView.h
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZChatViewController (ChatInputView)

- (void)updateUIForChatInputViewTextViewChanged:(CGSize)contentSize oldContentSize:(CGSize)oldContentSize;

@end

NS_ASSUME_NONNULL_END
