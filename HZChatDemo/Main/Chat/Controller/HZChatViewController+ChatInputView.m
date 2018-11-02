//
//  HZChatViewController+ChatInputView.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+ChatInputView.h"
#import "HZChatInputView.h"

@implementation HZChatViewController (ChatInputView)

- (void)updateUIWithKeyboardEventEndFrame:(CGRect)chatInputViewFrame
                               beginFrame:(CGRect)beginchatInputViewFrame
                                 duration:(CGFloat)duration
                                animation:(NSInteger)animation {
    
    __weak typeof (self) weakSelf = self;
    
    CGFloat transFormY = weakSelf.tableView.transform.ty + (CGRectGetMinY(chatInputViewFrame) - CGRectGetMinY(beginchatInputViewFrame));
    
    
    [UIView animateWithDuration:duration delay:0 options:animation animations:^{
        
        //调整chat input view position
        //weakSelf.chatInputView setFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        
        //调整table view positon
        [weakSelf.tableView setTransform:CGAffineTransformMakeTranslation(0, transFormY)];
        
    } completion:^(BOOL finished) {
        UIEdgeInsets insets = weakSelf.tableView.contentInset;
        [weakSelf.tableView setContentInset:UIEdgeInsetsMake(insets.top - transFormY, insets.left, insets.bottom, insets.right)];
    }];
}

- (void)updateUIForChatInputViewTextViewChanged:(CGSize)contentSize oldContentSize:(CGSize)oldContentSize {
    __weak typeof (self) weakSelf = self;
    
    CGFloat transFormY = weakSelf.tableView.transform.ty - (contentSize.height - oldContentSize.height);

    
    [UIView animateWithDuration:0 delay:0 options:7 animations:^{
        
        //调整chat input view position
        [weakSelf.chatInputView setFrame:CGRectMake(CGRectGetMinX(weakSelf.chatInputView.frame),
                                                    CGRectGetMinY(weakSelf.chatInputView.frame)
                                                    - (contentSize.height
                                                    - oldContentSize.height),
                                                    CGRectGetWidth(weakSelf.chatInputView.frame),
                                                    CGRectGetMaxY(weakSelf.chatInputView.frame)
                                                    - CGRectGetMinY(weakSelf.chatInputView.frame)
                                                    + (contentSize.height - oldContentSize.height))];
        
        
        //调整table view positon
        [weakSelf.tableView setTransform:CGAffineTransformMakeTranslation(0, transFormY)];
        
    } completion:^(BOOL finished) {
        UIEdgeInsets insets = weakSelf.tableView.contentInset;
        [weakSelf.tableView setContentInset:UIEdgeInsetsMake(insets.top - transFormY, insets.left, insets.bottom, insets.right)];
    }];
}

@end
