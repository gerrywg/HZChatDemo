//
//  HZChatInputView.m
//  HZChatDemo
//
//  Created by o888 on 2018/11/1.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZChatInputView.h"
#import <Masonry.h>

@interface HZChatInputView ()<UITextViewDelegate>
@property (strong, nonatomic) UIButton      *voiceButton;
@property (strong, nonatomic) UIButton      *emotionButton;
@property (strong, nonatomic) UIButton      *additionalButton;
@property (strong, nonatomic) UITextView    *textView;

@end

static CGFloat const chatInputViewBorderWidth   = 0.5;  //chat input view border width
static CGFloat const textViewBorderWidth        = 1;    //text view border width
static CGFloat const textViewCornerRadius       = 3;    //text view border width

static CGFloat const leftPadding    = 8.0;
static CGFloat const rightPadding   = 8.0;
static CGFloat const bottomPadding  = 11.0;
static CGFloat const innerPadding   = 8.0;
static CGFloat const buttonHeight   = 28.0;

@implementation HZChatInputView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)dealloc {
    
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)setupUI {
    
    //add subviews
    [self addSubview:self.voiceButton];
    [self addSubview:self.emotionButton];
    [self addSubview:self.additionalButton];
    [self addSubview:self.textView];
    
    //self settings
    [self setBackgroundColor:[UIColor colorWithRed:250 / 255.0
                                             green:250 / 255.0
                                              blue:250 / 255.0
                                             alpha:1]];
    
    self.layer.borderWidth = chatInputViewBorderWidth;
    self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
}

- (void)updateConstraints {
    __weak typeof (self) weakSelf = self;
    
    [self.voiceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(leftPadding);
        make.bottom.equalTo(weakSelf).with.offset(-bottomPadding);
        make.height.equalTo(@(buttonHeight));
        make.width.equalTo(weakSelf.voiceButton.mas_height);
    }];
    
    [self.emotionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.additionalButton.mas_left).with.offset(-innerPadding);
        make.bottom.equalTo(weakSelf).with.offset(-bottomPadding);
        make.height.equalTo(@(buttonHeight));
        make.width.equalTo(weakSelf.emotionButton.mas_height);
    }];
    
    [self.additionalButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-rightPadding);
        make.bottom.equalTo(weakSelf).with.offset(-bottomPadding);
        make.height.equalTo(@(buttonHeight));
        make.width.equalTo(weakSelf.additionalButton.mas_width);
    }];
    
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(innerPadding);
        make.bottom.equalTo(weakSelf).with.offset(-innerPadding);
        make.left.equalTo(weakSelf.voiceButton.mas_right).with.offset(innerPadding);
        make.right.equalTo(weakSelf.emotionButton.mas_left).with.offset(-innerPadding);
    }];
    
    [super updateConstraints];
}


- (UITextView *)textView {
    
    if (!_textView) {
        _textView = ({
            UITextView *textView = [UITextView new];
            
            textView.delegate = self;
            
            textView.layer.borderWidth  = textViewBorderWidth;
            textView.layer.borderColor  = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
            textView.layer.cornerRadius = textViewCornerRadius;
            
            [textView setBackgroundColor:[UIColor greenColor]];
            
            [textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
            
            textView;
        });
    }
    
    return _textView;
}

- (UIButton *)voiceButton {
    
    if (!_voiceButton) {
        
        _voiceButton = ({
            UIButton *button = [UIButton new];
            
            [button setImage:[UIImage imageNamed:@"chat_setmode_voice_btn_normal"] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(voiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _voiceButton;
}

- (void)voiceButtonClicked:(UIButton *)button {
    
}

- (UIButton *)emotionButton {
    
    if (!_emotionButton) {
        
        _emotionButton = ({
            UIButton *button = [UIButton new];
            
            [button setImage:[UIImage imageNamed:@"Album_ToolViewEmotion"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"] forState:UIControlStateHighlighted];
            
            [button addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _emotionButton;
}

- (void)emotionButtonClicked:(UIButton *)button {
    
}

- (UIButton *)additionalButton {
    
    if (!_additionalButton) {
        
        _additionalButton = ({
            UIButton *button = [UIButton new];
            
            [button setImage:[UIImage imageNamed:@"chat_setmode_add_btn_normal"] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(additionalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _additionalButton;
}

- (void)additionalButtonClicked:(UIButton *)button {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGSize contentSize      = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldContentSize   = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];

//        [self setFrame:CGRectMake(CGRectGetMinX(self.frame),
//                                           CGRectGetMaxY(self.frame)
//                                           - contentSize.height,
//                                           CGRectGetWidth(self.textView.frame),
//                                           contentSize.height)];
        if (oldContentSize.height<0) {
            return;
        }
        
        if (self.chatInputViewTextViewDidChangeContentSize) {
            self.chatInputViewTextViewDidChangeContentSize(contentSize, oldContentSize);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
