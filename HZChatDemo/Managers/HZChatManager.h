//
//  HZChatManager.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZChatBaseMessageTVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZChatManager : NSObject

@property (weak, nonatomic) id <HZChatBaseMessageTVCellDelegate> delegate;

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
