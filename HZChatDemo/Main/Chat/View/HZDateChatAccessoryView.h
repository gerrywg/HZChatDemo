//
//  HZDateChatAccessoryView.h
//  ypxsq
//
//  Created by o888 on 2018/7/26.
//  Copyright © 2018年 o888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZDateChatAccessoryView : UIView

@property (strong, nonatomic) void (^userDidClickedItem)(NSIndexPath *accessoryViewIndexPath);

@property (strong, nonatomic) NSArray *accesoryDataSource;

@end
