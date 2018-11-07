//
//  HZChatViewController+ChatInputView.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+ChatInputView.h"
#import "HZChatInputView.h"
#import <objc/runtime.h>

static char hz_chatInputViewContentSizeRefrenceValueKey;

@implementation HZChatViewController (ChatInputView)

- (NSValue *)chatInputViewContentSizeRefrenceValue {
    return objc_getAssociatedObject(self, &hz_chatInputViewContentSizeRefrenceValueKey);
}

- (void)setChatInputViewContentSizeRefrenceValue:(NSValue *)chatInputViewContentSizeRefrenceValue {
    objc_setAssociatedObject(self, &hz_chatInputViewContentSizeRefrenceValueKey, chatInputViewContentSizeRefrenceValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateUIForChatInputViewTextViewChanged:(CGSize)contentSize oldContentSize:(CGSize)oldContentSize {
    
    if (contentSize.height > 100) {
        
        //如果内容高度大于100, 那么返回, 不在更新chat input view 高度
        return;
    }
    
    __weak typeof (self) weakSelf = self;
    
    CGSize refrenceOldContentSize = oldContentSize;
    
    CGFloat transFormY = weakSelf.tableView.transform.ty - (contentSize.height - oldContentSize.height);
    
    if (self.chatInputViewContentSizeRefrenceValue) {
        
        refrenceOldContentSize = [self.chatInputViewContentSizeRefrenceValue CGSizeValue];
        
        transFormY = weakSelf.tableView.transform.ty - (contentSize.height - refrenceOldContentSize.height);
    }
    
    [UIView animateWithDuration:0 delay:0 options:7 animations:^{
        
        //调整chat input view position
        [weakSelf.chatInputView setFrame:CGRectMake(CGRectGetMinX(weakSelf.chatInputView.frame),
                                                    CGRectGetMinY(weakSelf.chatInputView.frame)
                                                    - (contentSize.height
                                                       - refrenceOldContentSize.height),
                                                    CGRectGetWidth(weakSelf.chatInputView.frame),
                                                    CGRectGetMaxY(weakSelf.chatInputView.frame)
                                                    - CGRectGetMinY(weakSelf.chatInputView.frame)
                                                    + (contentSize.height - refrenceOldContentSize.height))];
        
        
        //保存参考值
        self.chatInputViewContentSizeRefrenceValue = [NSValue valueWithCGSize:contentSize];
        
        //调整table view positon
        [weakSelf.tableView setTransform:CGAffineTransformMakeTranslation(0, transFormY)];
        
    } completion:^(BOOL finished) {
        
        UIEdgeInsets insets = weakSelf.tableView.contentInset;
        [weakSelf.tableView setContentInset:UIEdgeInsetsMake(insets.top - transFormY, insets.left, insets.bottom, insets.right)];
    }];
}

@end
