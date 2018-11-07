//
//  UIViewController+HZJSExtentsion.m
//  yiketang
//
//  Created by o888 on 2018/7/11.
//  Copyright © 2018年 o888. All rights reserved.
//

#import "UIViewController+HZJSExtentsion.h"
//#import <MapKit/MapKit.h>
#import <objc/runtime.h>
#import <Toast.h>
//#import "HZMOBServiceManager.h"
//#import "HZQRCodeScanViewController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>
#import <Photos/Photos.h>
#import <TJLImagePickerController.h>

static NSString *const locationManagerKey = @"locationManagerKey";

@implementation UIViewController (HZJSExtentsion)

- (void)setLocationManager:(CLLocationManager *)locationManager {
    objc_setAssociatedObject(self, &locationManagerKey, locationManager, OBJC_ASSOCIATION_RETAIN);
}

- (CLLocationManager *)locationManager {
    return objc_getAssociatedObject(self, &locationManagerKey);
}

#if 0
- (void)startOutsideNaviWithDesternationCoordinate:(CLLocationCoordinate2D)coordinate
                                      userLocation:(CLLocationCoordinate2D)userLocation
                                   originalAppName:(NSString *)appName {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"启动导航" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"alertController -- 自带地图");
        
        //使用自带地图导航
        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation]
                       launchOptions:@{
                                       MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsMapTypeKey: [NSNumber                                 numberWithInteger:MKMapTypeStandard],
                                       MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        
    }]];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"alertController -- 高德地图");
            //iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=39.92848272&slon=116.39560823&sname=A&did=BGVIS2&dlat=39.98848272&dlon=116.47560823&dname=B&dev=0&t=0
            NSString *urlstring =[[NSString stringWithFormat:@"iosamap://path?sourceApplication= &sid=BGVIS1&sname=我的位置&did=BGVIS2&dname=终点&dlat=%f&dlon=%f&dev=0&t=0",coordinate.latitude,coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSString *urlsting =[[NSString stringWithFormat:@"iosamap://path?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlstring]];
        }]];
    }
    
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //baidumap://map/direction?origin=34.264642646862,108.95108518068&destination=40.007623,116.360582&mode=driving&src=webapp.navi.yourCompanyName.yourAppName
            NSString *urlstring =[[NSString stringWithFormat:@"baidumap://map/direction?origin=name:我的位置|latlng:%f,%f&destination=name:终点|latlng:%f,%f&mode=driving&src=webapp.navi.yourCompanyName.yourAppName", userLocation.latitude,userLocation.longitude,coordinate.latitude,coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlstring]];
        }]];
    }
    
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"用腾讯地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0&referer=%@",coordinate.latitude, coordinate.longitude,appName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlString]];
        }]];
    }
    
    alertVC.popoverPresentationController.sourceView = self.view;
    alertVC.popoverPresentationController.sourceRect = CGRectMake(0, 0, 1, 1);
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self.navigationController presentViewController:alertVC animated:YES completion:^{
        
    }];
}
#endif

- (void)startUserLocation {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            return;
            break;
        case kCLAuthorizationStatusDenied:
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请到手机系统\"设置->隐私->开启定位\",\n启用该app的定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return;
            }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            [self.view makeToast:@"该手机未开启定位"];
            return;
        }
            break;
            
        default:
            break;
    }
    
    [self.locationManager startUpdatingLocation];
}


#pragma mark -- core location delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}

#if 0
#pragma mark -- start 3rd login service
- (void)startThirdPartyLoginWithPlatform:(SSDKPlatformType)platformType {
    [[HZMOBServiceManager sharedManager]thirdPartyLoginWithChannel:platformType];
}
#endif

#pragma mark -- telephone call
- (void)telephoneCallWithNumber:(NSString *)number {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",number];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#if 0
#pragma mark -- qrcode scan
- (void)qrScanWithCallBack:(void (^)(NSArray<__kindof AVMetadataObject *> *metadataObjects, BOOL success))scanResult {
    HZQRCodeScanViewController *vc = [HZQRCodeScanViewController new];
    [vc setScanResult:scanResult];
    [self.navigationController pushViewController:vc animated:YES];
}
#endif


#if 0
- (void)shareWithText:(NSString *)text images:(NSArray *)images url:(NSString *)urlStr title:(NSString *)title {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:images
                                        url:[NSURL URLWithString:urlStr]
                                      title:title
                                       type:SSDKContentTypeAuto];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}
#endif

- (void)saveImage:(UIImage *)image finished:(void (^)(BOOL success, NSError * _Nullable error))completionHandler {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:completionHandler];
}

- (void)saveImageToAblum:(UIImage *)image {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof (self) weakSelf = self;
    [alertVC addAction:[UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf saveImage:image finished:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [weakSelf.view makeToast:@"保存成功"];
                }else {
                    [weakSelf.view makeToast:@"保存失败"];
                }
            });
        }];
    }]];
    
    alertVC.popoverPresentationController.sourceView = self.view;
    alertVC.popoverPresentationController.sourceRect = self.view.frame;
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alertVC animated:YES completion:^{
        
    }];
    
}


//发短信
-(void)sendMessage:(NSString *)mobile{
    NSLog(@"发短信");
    
    NSString *message =@"";
    NSLog(@"message = %@",message);
    
    NSString *phone = mobile;
    NSLog(@"phone = %@",phone);
    
    //传入要发送到得电话号码，和短信界面预写入短信的内容，调用此方法即可跳到短信发送界面
    [self showMessageView:@[phone] title:@"xxx" body:message];
}


-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

//发短信
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            NSLog(@"信息发送成功");
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            NSLog(@"信息传送失败");
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            NSLog(@"信息被用户取消传送");
            
            break;
        default:
            break;
    }
}


/**
 调用相机
 
 @param controller from controller
 @param successHanlder success call back
 */
- (void)hz_showCameraWithController:(UIViewController *)controller successBlock:(void (^)(UIImage *image))successHanlder {
    [[TJLImagePickerController sharedInstance]showCameraInController:controller successBlock:^(UIImage *image) {
        if (successHanlder) {
            successHanlder(image);
        }
    }];
}


/**
 调用相册
 
 @param controller from controller
 @param successHanlder success call back
 */
- (void)hz_showPhotoAblumWithController:(UIViewController *)controller total:(NSInteger)total successBlock:(void (^)(NSArray *imageArray))successHanlder {
    [[TJLImagePickerController sharedInstance]showPickerInController:controller total:total successBlock:^(NSArray *imageArray) {
        if (successHanlder) {
            successHanlder(imageArray);
        }
    }];
}



@end
