//
//  HZBubbleView.h
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/4.
//  Copyright © 2018 o888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZChatEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZBubbleView : UIView

@property (assign, nonatomic) HZChatCellSide chatCellSide;

@property (strong, nonatomic) UIColor *chatArrowBorderColor;
@property (assign, nonatomic) CGFloat chatArrowBorderWidth;

@property (strong, nonatomic) UIColor *hz_fillColor;

@end

NS_ASSUME_NONNULL_END
