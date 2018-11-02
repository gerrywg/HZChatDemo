//
//  HZChatBaseMessageTVCell.h
//  HZChatDemo
//
//  Created by o888 on 2018/11/2.
//  Copyright © 2018 o888. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HZChatCellContentType) {
    HZChatCellContentTypeCustom = -1,      /* 自定义 */
    HZChatCellContentTypeText,             /* 文字 */
    HZChatCellContentTypeImage,            /* 图片 */
    HZChatCellContentTypeVoice,            /* 语音 */
    HZChatCellContentTypeShareInfo,        /* 分享类型, 就是有图片, title, 文字 和跳转链接 */
    HZChatCellContentTypeMap               /* 地图类型 */
};

typedef NS_ENUM(NSUInteger, HZChatCellSide) {
    HZChatCellSideMySide,
    HZChatCellSideOtherSide
};

@protocol HZChatBaseMessageTVCellDelegate <NSObject>

- (HZChatCellSide) hz_chatCellSideWithReuseIdentifier:(NSString *)reuseIdentifier;

- (HZChatCellContentType) hz_chatCellContentTypeWithReuseIdentifier:(NSString *)reuseIdentifier;

@optional

- (NSString *) hz_customChatCellClassNameWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface HZChatBaseMessageTVCell : UITableViewCell

@property (strong, nonatomic) UIButton *avatarButton;

@end

NS_ASSUME_NONNULL_END
