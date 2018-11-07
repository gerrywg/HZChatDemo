//
//  HZDateChatAccessoryView.m
//  ypxsq
//
//  Created by o888 on 2018/7/26.
//  Copyright © 2018年 o888. All rights reserved.
//

#import "HZDateChatAccessoryView.h"
#import "HZDateChatBelowCVCell.h"
#import "HZUIMacro.h"
#import <Masonry.h>

@interface HZDateChatAccessoryView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *dataSource;

//@property (strong, nonatomic) NSArray *dataSource;

@end


@implementation HZDateChatAccessoryView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    __weak typeof (self) weakSelf = self;
    
    [self setBackgroundColor:HZBGColor];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.minimumLineSpacing = 0.0;
            layout.minimumInteritemSpacing = 0.0;
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            
            collectionView.dataSource = self;
            collectionView.delegate = self;
            
            [collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            
            [collectionView setBackgroundColor:[UIColor clearColor]];
            
            [collectionView registerClass:[HZDateChatBelowCVCell class] forCellWithReuseIdentifier:@"HZDateChatBelowCVCell"];
            
            
            collectionView;
        });
    }
    return _collectionView;
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    cell = ({
        HZDateChatBelowCVCell *cell_c = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZDateChatBelowCVCell" forIndexPath:indexPath];
        cell_c.itemDict = self.dataSource[indexPath.row];
        
        //新效果, 需要显示highlighted状态
        __weak typeof (self) weakSelf = self;
        [cell_c setDidSelectedItem:^(UIButton *button) {
            CGPoint point = [button.superview convertPoint:button.center toView:collectionView];
            NSIndexPath *selectedIndexPath = [collectionView indexPathForItemAtPoint:point];
            if (weakSelf.userDidClickedItem) {
                weakSelf.userDidClickedItem(selectedIndexPath);
            }
        }];
        
        cell_c;
    });
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //每行放4个
    return CGSizeMake(KSCREEN_WIDTH/4.0-1, KSCREEN_WIDTH/4.0-1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.userDidClickedItem) {
        self.userDidClickedItem(indexPath);
    }
}


- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)setAccesoryDataSource:(NSArray *)accesoryDataSource {
    _accesoryDataSource = accesoryDataSource;
    self.dataSource = accesoryDataSource;
    [self.collectionView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
#if 0
    if ([keyPath isEqualToString:@"contentSize"]) {
        WS(weakSelf);
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
            make.height.equalTo(@(weakSelf.collectionView.contentSize.height));
        }];
    }
#endif
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
