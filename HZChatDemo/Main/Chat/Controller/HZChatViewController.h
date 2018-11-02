//
//  HZChatViewController.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZBaseViewController.h"

@class HZChatInputView;

NS_ASSUME_NONNULL_BEGIN

@interface HZChatViewController : HZBaseViewController
@property (strong, nonatomic) HZChatInputView *chatInputView;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
