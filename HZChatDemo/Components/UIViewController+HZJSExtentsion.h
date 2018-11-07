//
//  UIViewController+HZJSExtentsion.h
//  yiketang
//
//  Created by o888 on 2018/7/11.
//  Copyright © 2018年 o888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <ShareSDK/ShareSDK.h>
#import <MessageUI/MessageUI.h>
@class AVMetadataObject;

@interface UIViewController (HZJSExtentsion)<CLLocationManagerDelegate,MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;


/**
 UIAlertController with confirm and cancel button, and a do action block
 
 @param title alert title
 @param message alert message
 @param doAction do action block
 */
- (void)confirmCancelAlertWith:(NSString *)title message:(NSString *)message actionBlock:(void (^)(void))doAction;

/**
 UIAlertController with confirm and cancel button, and a do action block
 
 @param title alert title
 @param message alert message
 @param doAction do action block
 */
- (void)warningAlertWith:(NSString *)title message:(NSString *)message actionBlock:(void (^)(void))doAction;


/**
 导航

 @param coordinate 目的地坐标
 @param userLocation 用户当前坐标
 @param appName App名称
 */
- (void)startOutsideNaviWithDesternationCoordinate:(CLLocationCoordinate2D)coordinate
                                      userLocation:(CLLocationCoordinate2D)userLocation
                                   originalAppName:(NSString *)appName;



/**
 启动定位
 */
- (void)startUserLocation;

#if 0
/**
 启动第三方登录

 @param platformType mob第三方登录平台
 */
- (void)startThirdPartyLoginWithPlatform:(SSDKPlatformType)platformType;
#endif

/**
 播出电话

 @param number 电话号码
 */
- (void)telephoneCallWithNumber:(NSString *)number;


/**
 启动二维码扫描

 @param scanResult 二维码扫描回掉block
 */
- (void)qrScanWithCallBack:(void (^)(NSArray<__kindof AVMetadataObject *> *metadataObjects, BOOL success))scanResult;


/**
 分享

 @param text 分享内容
 @param images 分享图片链接
 @param urlStr 跳转url
 @param title 分享标题
 */
- (void)shareWithText:(NSString *)text images:(NSArray *)images url:(NSString *)urlStr title:(NSString *)title;


/**
 保存图片到相册

 @param image 需要保存的图片
 @param completionHandler 完成后的回调
 */
- (void)saveImage:(UIImage *)image finished:(void (^)(BOOL success, NSError * _Nullable error))completionHandler;



/**
 包含alert sheet, 保存照片到相册

 @param image 需要保存的图片
 */
- (void)saveImageToAblum:(UIImage *)image;


/**
 发送短信

 @param mobile 手机号
 */
-(void)sendMessage:(NSString *)mobile;


/**
 调用相机

 @param controller from controller
 @param successHanlder success call back
 */
- (void)hz_showCameraWithController:(UIViewController *)controller successBlock:(void (^)(UIImage *image))successHanlder;


/**
 调用相册

 @param controller from controller
 @param total number of photos of selection
 @param successHanlder sucess call back
 */
- (void)hz_showPhotoAblumWithController:(UIViewController *)controller total:(NSInteger)total successBlock:(void (^)(NSArray *imageArray))successHanlder;


@end
