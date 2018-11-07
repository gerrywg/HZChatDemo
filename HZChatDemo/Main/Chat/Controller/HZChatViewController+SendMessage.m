//
//  HZChatViewController+SendMessage.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/7.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+SendMessage.h"
#import "HZChatViewController+ReceiveMessage.h"
#import "HZChatMessageModel.h"
#import <UIView+Toast.h>

@implementation HZChatViewController (SendMessage)

- (void)sendTextMessage:(UITextView *)textView {
    
    if (nil == textView.text || [textView.text isEqualToString:@""]) {
        
        [self.view makeToast:@"内容为空"];
        
        return;
    }
    
    HZChatMessageModel *textMessageModel = [HZChatMessageModel new];
    
    [textMessageModel setContentType:HZChatContentTypeText];
    
    [textMessageModel setMessage:textView.text];
    
    //self.dataSource = [self.dataSource arrayByAddingObject:textMessageModel];
    [self receivedMessageModel:textMessageModel];
    
}

@end
