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

/**
 refrence value of content size for chat input view. this value is record only for content size of chat input view frame changed and ignored for content size of chat input view frame not changed, even if the content size changed.
 */
@property (strong, nonatomic) NSValue *chatInputViewContentSizeRefrenceValue;

- (void)updateUIForChatInputViewTextViewChanged:(CGSize)contentSize oldContentSize:(CGSize)oldContentSize;

@end

NS_ASSUME_NONNULL_END
