//
//  HZChatViewController.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatViewController.h"
#import "HZChatViewController+KeyboardEvent.h"
#import "HZChatViewController+ChatTableView.h"
#import "HZChatViewController+ChatInputView.h"
#import "HZChatViewController+SendMessage.h"
#import "HZChatViewController+SendImage.h"
#import "HZChatInputView.h"
#import "HZChatTextMessageTVCell.h"
#import "HZChatImageMessageTVCell.h"
#import "HZChatMessageModel.h"
#import "HZUIMacro.h"
#import <SDWebImageDownloader.h>
#import "HZDateChatAccessoryView.h"

@interface HZChatViewController ()<UITableViewDataSource, UITableViewDelegate, HZChatBaseMessageTVCellDelegate>

@property (strong, nonatomic) HZDateChatAccessoryView *chatAccessoryView;
@property (strong, nonatomic) NSArray *accessoryDataSource;

@end

static CGFloat const chatInputViewHeight    = 50.0;
static CGFloat const normalNAVIHeight       = 64.0;

@implementation HZChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialSettings];
    
    [self setupUI];
}

- (void)dealloc {
    [self removeNotifications];
}

- (void)initialSettings {
    [self addKeyboardNotifications];
}

- (void)addNotifications {
    [self addKeyboardNotifications];
}

- (void)removeNotifications {
    [self removeKeyboardNotifications];
}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatInputView];
    
    [self.tableView setFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame) + normalNAVIHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (normalNAVIHeight + chatInputViewHeight))];
    
    [self.chatInputView setFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame) - chatInputViewHeight, CGRectGetWidth(self.view.frame), chatInputViewHeight)];
    
    if (@available(iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView setContentInset:UIEdgeInsetsZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self scrollToBottom];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    [self.tableView setFrame:CGRectMake(CGRectGetMinX(self.tableView.frame), self.view.safeAreaInsets.top, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.view.frame) - (self.view.safeAreaInsets.top + chatInputViewHeight))];
    
    [self.chatInputView setFrame:CGRectMake(CGRectGetMinX(self.chatInputView.frame), CGRectGetMaxY(self.view.frame) - chatInputViewHeight - self.view.safeAreaInsets.bottom, CGRectGetWidth(self.view.frame), chatInputViewHeight)];
}


- (HZChatInputView *)chatInputView {
    
    if (!_chatInputView) {
        _chatInputView = ({
            HZChatInputView *chatInputView = [HZChatInputView new];
            
            __weak typeof (self) weakSelf = self;
            [chatInputView setChatInputViewTextViewDidChangeContentSize:^(CGSize contentSize, CGSize oldContentSize) {
               
                [weakSelf updateUIForChatInputViewTextViewChanged:contentSize oldContentSize:oldContentSize];
            }];
            
            [chatInputView setChatInputViewSendKeyClicked:^(UITextView * _Nonnull textView) {
               
                [weakSelf sendTextMessage:textView];
                
                //clear text view
                textView.text = nil;
            }];
            
            chatInputView;
        });
    }
    return _chatInputView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            
            tableView.dataSource = self;
            tableView.delegate = self;
            
            [tableView setBackgroundColor:[UIColor colorWithRed:0xf0/255.0 green:0xf0/255.0 blue:0xf0/255.0 alpha:1.0]];
            [tableView setTableFooterView:[UIView new]];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            tableView.rowHeight             = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight    = 44;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewTapAction:)];
            [tableView addGestureRecognizer:tap];
            
            [tableView registerClass:[HZChatTextMessageTVCell class] forCellReuseIdentifier:@"leftText"];
            [tableView registerClass:[HZChatTextMessageTVCell class] forCellReuseIdentifier:@"rightText"];
            
            [tableView registerClass:[HZChatImageMessageTVCell class] forCellReuseIdentifier:@"leftImage"];
            [tableView registerClass:[HZChatImageMessageTVCell class] forCellReuseIdentifier:@"righImage"];
            
            tableView;
        });
    }
    
    return _tableView;
}

- (void)tableViewTapAction:(UIGestureRecognizer *)gest {
    [self.view endEditing:YES];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.dataSource.count;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    BOOL left = indexPath.row % 2;
    
    HZChatMessageModel *messageModel = self.dataSource[indexPath.row];
    
    switch (messageModel.contentType) {
        case HZChatContentTypeText:
        cell = ({
            HZChatTextMessageTVCell *cell_c = nil;
            if (left) {
                
                cell_c = [tableView dequeueReusableCellWithIdentifier:@"leftText"];
                cell_c.hz_delegate = self;
                
            }else {
                
                cell_c = [tableView dequeueReusableCellWithIdentifier:@"rightText"];
                cell_c.hz_delegate = self;
            }
            
            cell_c.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell_c.messageModel = messageModel;
            
            cell_c;
        });
            break;
        case HZChatContentTypeImage:
            cell = ({
                HZChatImageMessageTVCell *cell_c = nil;
                if (left) {
                    
                    cell_c = [tableView dequeueReusableCellWithIdentifier:@"leftImage"];
                    
                    if (!cell_c) {
                        cell_c = [[HZChatImageMessageTVCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"leftImage"];
                    }
                    
                    cell_c.hz_delegate = self;
                    
                }else {
                    
                    cell_c = [tableView dequeueReusableCellWithIdentifier:@"rightImage"];
                    if (!cell_c) {
                        cell_c = [[HZChatImageMessageTVCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"rightImage"];
                    }
                    cell_c.hz_delegate = self;
                }
                
                cell_c.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell_c.messageModel = messageModel;
                
                cell_c;
            });
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        //_dataSource = [UIFont familyNames];
        
        NSMutableArray *arr = [NSMutableArray array];
#if 0
        for (int i = 0; i<10; i++) {
            HZChatMessageModel *model = [[HZChatMessageModel alloc]init];
            model.messageId = @(i);
            
            BOOL result = i%2;
            
            if (result) {
                model.mediaContentDict = @{@"imageURL":IMAGE_URL1};
            }else{
                model.mediaContentDict = @{@"imageURL":IMAGE_URL2};
            }
            
                    __weak typeof (self) weakSelf = self;
            
                    if (!model.hz_userInfo) {
            
                        NSURL *url = [NSURL URLWithString:model.mediaContentDict[@"imageURL"]];
            
                        [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
                        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
                            model.hz_userInfo = @{@"imageWidth":@(image.size.width),
                                                  @"imageHeight":@(image.size.height),
                                                  @"image":image
                                                  };
                            [weakSelf reloadDataForMessage:model];
                        }];
                    }
            
            [arr addObject:model];
            
        }
#endif
        
        _dataSource = [arr copy];
    }
    return _dataSource;
}

- (void)reloadDataForMessage:(HZChatMessageModel *)model {
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
//
//
//
//    return;
    
    NSInteger index = 0;
    BOOL find = NO;
    for (HZChatMessageModel *model1 in self.dataSource) {
        if ([model1.messageId isEqualToNumber:model.messageId]) {
            
            find = YES;
            break;
        }
        
        index += 1;
    }
    
    if (find) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - hz chat cell delegate
- (HZChatCellSide) hz_chatCellSideWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([reuseIdentifier isEqualToString:@"leftText"]) {
        
        return HZChatCellSideOtherSide;
    }
    
    else if ([reuseIdentifier isEqualToString:@"rightText"]){
        return HZChatCellSideMySide;
    }
    
    else if ([reuseIdentifier isEqualToString:@"leftImage"]){
        return HZChatCellSideOtherSide;
    }
    
    else if ([reuseIdentifier isEqualToString:@"rightImage"]){
        return HZChatCellSideMySide;
    }
    
    return HZChatCellSideMySide;
}

- (NSArray *)accessoryDataSource {
    if (!_accessoryDataSource) {
        _accessoryDataSource = ({
            NSMutableArray *arr = [NSMutableArray array];
            //NSArray *titles = @[@"相册",@"相机",@"语音"];
            NSArray *titles = @[@"相册",@"相机"];
            NSArray *imageNames = @[@"actionbar_picture_icon", @"actionbar_camera_icon",@"chat_Voice_small"];
            NSArray *selectedImageNames = @[@"actionbar_picture_icon", @"actionbar_camera_icon",@"chat_Voice_click_small"];
            
            for (int i = 0; i<titles.count; i++) {
                NSDictionary *dict = @{@"title":titles[i],
                                       @"imageName":imageNames[i],
                                       @"selectedImageName":selectedImageNames[i]
                                       };
                [arr addObject:dict];
            }
            
            [arr copy];
        });
    }
    return _accessoryDataSource;
}

#pragma mark -- Chat accessory view, 底部附件view
- (HZDateChatAccessoryView *)chatAccessoryView {
    if (!_chatAccessoryView) {
        _chatAccessoryView = ({
            HZDateChatAccessoryView *chatAccessoryView = [HZDateChatAccessoryView new];
            chatAccessoryView.accesoryDataSource = self.accessoryDataSource;
            __weak typeof (self) weakSelf = self;
            [chatAccessoryView setUserDidClickedItem:^(NSIndexPath *accessoryViewIndexPath) {
                switch (accessoryViewIndexPath.row) {
                    case 0:
                        //相册
                    {
                        //选中,跳转到相册界面
                        [weakSelf userDidClickedPhotoAblumItem];
                        
                        //UI 操作
                        [weakSelf hideChatAccessoryViewAnimated];
                    }
                        
                        break;
                    case 1:
                        //相机
                    {
                        //选中,跳转到相机界面
                        [weakSelf userDidClickedCamearaItem];
                        
                        //UI 操作
                        [weakSelf hideChatAccessoryViewAnimated];
                    }
                        
                        break;
                    case 2:
                        //语音
                    {
                        //UI 操作
                        //[self hideChatAccessoryViewAnimated];
                        
                        //选中,跳转到地址选择界面
                        //[weakSelf showVoiceRecordView];
                    }
                        
                        break;
                        
                    default:
                        break;
                }
            }];
            
            chatAccessoryView;
        });
    }
    return _chatAccessoryView;
}


- (void)showChatAccessoryViewAnimated {
#if 0
    if (self.isAccessoryViewShow) {
        return;
    }
    
    self.isAccessoryViewShow = YES;
    [self.view endEditing:YES];
    
    //交换位置, 把要显示的view放在最前面
    NSInteger accIndex = 0;
    NSInteger daiyIndex = 0;
    for (int i = 0; i<self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        if ([view isKindOfClass:[HZDateChatAccessoryView class]]) {
            accIndex = i;
        }else if ([view isKindOfClass:[HZDateChatDailyWordsView class]]){
            daiyIndex = i;
        }
    }
    
    if (accIndex<daiyIndex) {
        [self.view exchangeSubviewAtIndex:accIndex withSubviewAtIndex:daiyIndex];
    }
#endif
    
    
    CGFloat height = CGRectGetMaxY(self.view.frame) - CGRectGetMinY(self.chatAccessoryView.frame);
    //[self chatInputViewChangePostion:-height animatedDuration:KeyboardAnimationDuration animatedOption:7 scrollToIndexPath:nil needToScroll:NO];
    
}

- (void)hideChatAccessoryViewAnimated {
    //self.isAccessoryViewShow = NO;
    
    //[self chatInputViewChangePostion:0 animatedDuration:KeyboardAnimationDuration animatedOption:7 scrollToIndexPath:nil needToScroll:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
