//
//  HZChatViewController+KeyboardEvent.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+KeyboardEvent.h"
#import "HZChatInputView.h"

#import "HZChatViewController+ChatTableView.h"

//static CGFloat const chatInputViewHeight = 50.0;
//static CGFloat const normalNAVIHeight = 64.0;

@implementation HZChatViewController (KeyboardEvent)

- (void)addKeyboardNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillHideAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardwillShowAction:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    CGRect beginKeyboardFrame   = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardFrame        = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat animCurveKey = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self scrollToBottom];
    
    [self updateUIWithKeyboardEventEndFrame:keyboardFrame
                                 beginFrame:beginKeyboardFrame
                                   duration:duration
                                  animation:animCurveKey];
}

- (void)keyboardwillHideAction:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    CGRect beginKeyboardFrame   = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardFrame        = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSInteger animCurveKey = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self updateUIWithKeyboardEventEndFrame:keyboardFrame
                                 beginFrame:beginKeyboardFrame
                                   duration:duration
                                  animation:animCurveKey];
}


- (void)updateUIWithKeyboardEventEndFrame:(CGRect)keyboardFrame
                               beginFrame:(CGRect)beginKeyboardFrame
                                 duration:(CGFloat)duration
                                animation:(NSInteger)animation {
    
    __weak typeof (self) weakSelf = self;
    
    CGFloat transFormY          = weakSelf.tableView.transform.ty + (CGRectGetMinY(keyboardFrame) - CGRectGetMinY(beginKeyboardFrame));
    CGFloat contentInsetChangeY = CGRectGetMinY(keyboardFrame) - CGRectGetMinY(beginKeyboardFrame);
    
    [UIView animateWithDuration:duration delay:0 options:animation animations:^{
        
        //调整chat input view position
        if (@available(iOS 11.0, *)) {
            [weakSelf.chatInputView setFrame:CGRectMake(CGRectGetMinX(weakSelf.chatInputView.frame),
                                                        CGRectGetMinY(keyboardFrame)
                                                        - CGRectGetHeight(weakSelf.chatInputView.frame)
                                                        - self.view.safeAreaInsets.bottom,
                                                        CGRectGetWidth(weakSelf.chatInputView.frame),
                                                        CGRectGetHeight(weakSelf.chatInputView.frame))];
        }else {
            [weakSelf.chatInputView setFrame:CGRectMake(CGRectGetMinX(weakSelf.chatInputView.frame),
                                                        CGRectGetMinY(keyboardFrame)
                                                        - CGRectGetHeight(weakSelf.chatInputView.frame),
                                                        CGRectGetWidth(weakSelf.chatInputView.frame),
                                                        CGRectGetHeight(weakSelf.chatInputView.frame))];
        }
        
        //调整table view positon, 此处conteng inset必须放在这里, 不然会有跳动
        UIEdgeInsets insets = weakSelf.tableView.contentInset;
        [weakSelf.tableView setContentInset:UIEdgeInsetsMake(insets.top - contentInsetChangeY, insets.left, insets.bottom, insets.right)];
        [weakSelf.tableView setTransform:CGAffineTransformMakeTranslation(0, transFormY)];

    } completion:^(BOOL finished) {
        
        
    }];
}

@end
