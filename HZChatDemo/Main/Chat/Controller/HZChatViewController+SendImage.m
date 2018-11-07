//
//  HZChatViewController+SendImage.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/7.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController+SendImage.h"
#import "UIViewController+HZJSExtentsion.h"

@implementation HZChatViewController (SendImage)

#pragma mark - accessory view did selected action methods

- (void)userDidClickedPhotoAblumItem {
    [self hz_showPhotoAblumWithController:self total:9 successBlock:^(NSArray *imageArray) {
        __weak typeof (self) weakSelf = self;
        
        if (imageArray.count) {
#if 0
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i<imageArray.count; i++) {
                UIImage *compressedImage = [HZTools compressImageSize:imageArray[i] toByte:UpLoadImageByteSize];
                [arr addObject:compressedImage];
            }

            [[HZImageUploader sharedManager]uploadChatImageArray:[arr copy] result:^(HZImageUploadResult *result) {
                if (result.result) {
                    //此处进行http请求
                    
                    [weakSelf sendImageChatMessageWithImageURLArray:result.urlArray];
                }else {
                    [weakSelf showHint:@"上传图片失败"];
                }
            }];
#endif
        }
    }];
}

- (void)userDidClickedCamearaItem {
    __weak typeof (self) weakSelf = self;
    
    [self hz_showCameraWithController:weakSelf successBlock:^(UIImage *image) {
#if 0
        UIImage *compressedImage = [HZTools compressImageSize:image toByte:UpLoadImageByteSize];
        
        [[HZImageUploader sharedManager]uploadChatImageArray:@[compressedImage] result:^(HZImageUploadResult *result) {
            if (result.result) {
                //此处进行http请求
                
                [weakSelf sendImageChatMessageWithImageURLArray:result.urlArray];
            }else {
                [weakSelf showHint:@"上传图片失败"];
            }
        }];
#endif
    }];
}


/**
 发送图片消息
 
 @param imageURLArray image URL array
 */
- (void)sendImageChatMessageWithImageURLArray:(NSArray *)imageURLArray {
    if (imageURLArray.count==0) {
        return;
    }
    
#if 0
    NSNumber *otherUserId = @(0);
    switch (self.chatType) {
        case HZChatMessageTypeVip:
            //普通用户
            otherUserId = self.receiverId;
            break;
        case HZChatMessageTypeCustomer:
            //客服
            otherUserId = self.customerId;
            break;
            
        default:
            return;
            break;
    }
    
    NSDictionary *parameters = @{@"userId":[HZUserManager sharedManager].userInfo.userID,
                                 @"otherUserId":otherUserId,
                                 @"chatImgs":imageURLArray,
                                 @"type":@(self.chatType)
                                 };
    DLog(@"--%@",parameters);
    NSURLSessionTask *task = [self jsonRequestWithTokenHeaderCmd:@"/message/sendChatImgs.do" para:parameters success:^{
        
    } error:^(NSError *error) {
        
    }];
    task.notAllowedIgnoreFlag = YES;
#endif
    
}

@end
