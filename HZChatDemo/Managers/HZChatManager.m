//
//  HZChatManager.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatManager.h"

static HZChatManager *manager = nil;

@implementation HZChatManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            
            manager = [[self alloc]init];
        }
    });
    
    return manager;
}

@end
