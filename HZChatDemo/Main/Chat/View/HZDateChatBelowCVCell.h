//
//  HZDateChatBelowCVCell.h
//  ypxsq
//
//  Created by o888 on 2018/7/26.
//  Copyright © 2018年 o888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZDateChatBelowCVCell : UICollectionViewCell

@property (strong, nonatomic) NSDictionary *itemDict;

@property (copy, nonatomic) void (^didSelectedItem)(UIButton *button);

@end
