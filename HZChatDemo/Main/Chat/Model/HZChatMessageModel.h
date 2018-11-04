//
//  HZChatMessageModel.h
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/3.
//  Copyright © 2018 o888. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YYModel.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HZChatContentType) {
    HZChatContentTypeCustom = -1,      /* 自定义 */
    HZChatContentTypeText,             /* 文字 */
    HZChatContentTypeImage,            /* 图片 */
    HZChatContentTypeVoice,            /* 语音 */
    HZChatContentTypeShareInfo,        /* 分享类型, 就是有图片, title, 文字 和跳转链接 */
    HZChatContentTypeMap               /* 地图类型 */
};

@interface HZChatMessageModel : NSObject<YYModel>

@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) NSNumber          *messageId;
@property (copy, nonatomic) NSString            *message;
@property (assign, nonatomic) HZChatContentType *contentType;
@property (strong, nonatomic) NSDictionary      *mediaContentDict;

@property (copy, nonatomic) NSString *senderId;
@property (copy, nonatomic) NSString *senderHeadImageURLString;
@property (copy, nonatomic) NSString *receiverId;
@property (copy, nonatomic) NSString *receiverHeadImageURLString;

@property (strong, nonatomic) NSNumber  *sendTimeStamp;
@property (assign, nonatomic) BOOL      shouldShowSendTime;

@end

NS_ASSUME_NONNULL_END
