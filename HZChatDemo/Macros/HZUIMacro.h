//
//  HZUIMacro.h
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/3.
//  Copyright © 2018 o888. All rights reserved.
//

#ifndef HZUIMacro_h
#define HZUIMacro_h

#import <UIKit/UIKit.h>

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXSM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define WG_isIPhone4 (ScreenHeight ==  480 ? YES : NO )

#define IMAGE_URL1 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541351367217&di=5b36bc2bba15a9a282e66e4ca7b7d0a0&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2Fqk%2Fback_origin_pic%2F00%2F02%2F00%2Fa868a6bbc4b858f7cd1cf63cc93f4875.jpg"

#define IMAGE_URL2 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541351778065&di=30a1eef2e7cae2e9f9f0152eebc2f09b&imgtype=0&src=http%3A%2F%2Fpic.ffpic.com%2Ffiles%2F2014%2F0523%2F0522jxhafjiphonebz10.jpg"

/***
 * 颜色
 **/
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WECHAT_GREEN_COLOR [UIColor greenColor]
#define WECHAT_MEDIAVIEW_BORDER_COLOR [UIColor darkGrayColor]

#define HZBGColor HexColor(0xF0F0F0)

#endif /* HZUIMacro_h */
