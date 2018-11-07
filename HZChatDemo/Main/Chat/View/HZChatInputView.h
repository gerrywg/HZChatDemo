//
//  HZChatInputView.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZChatInputView : UIView

@property (copy, nonatomic) void (^chatInputViewTextViewDidChangeContentSize)(CGSize contentSize, CGSize oldContentSize);
@property (copy, nonatomic) void (^chatInputViewSendKeyClicked)(UITextView *textView);

@end

NS_ASSUME_NONNULL_END
