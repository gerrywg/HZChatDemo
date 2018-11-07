//
//  HZChatViewController+ChatTableView.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+ChatTableView.h"

@implementation HZChatViewController (ChatTableView)

- (void)scrollToBottom {
    
    if (self.dataSource.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

@end
