//
//  HZChatViewController+ReceiveMessage.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/7.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+ReceiveMessage.h"
#import "HZChatMessageModel.h"

@implementation HZChatViewController (ReceiveMessage)

- (void)receivedMessageModel:(HZChatMessageModel *)messageModel {
    
    self.dataSource = [self.dataSource arrayByAddingObject:messageModel];
 
    NSIndexPath* insertion = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[ insertion ] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:insertion atScrollPosition:UITableViewScrollPositionBottom animated:true];
    
}

@end
