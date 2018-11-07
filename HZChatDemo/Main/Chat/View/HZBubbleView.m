//
//  HZBubbleView.m
//  HZChatDemo
//
//  Created by Gang Wang on 2018/11/4.
//  Copyright © 2018 o888. All rights reserved.
//

#import "HZBubbleView.h"
#import "HZUIMacro.h"
#import "HZChatConstants.h"

@implementation HZBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setContentMode:UIViewContentModeRedraw];
        
        self.chatArrowBorderColor = WECHAT_MEDIAVIEW_BORDER_COLOR;
        self.chatArrowBorderWidth = mediaArrowViewBorderWidth;
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)setChatCellSide:(HZChatCellSide)chatCellSide {
    
    _chatCellSide = chatCellSide;
    
    [self setNeedsDisplay];
}

- (void)setChatArrowBorderWidth:(CGFloat)chatArrowBorderWidth {
    
    _chatArrowBorderWidth = chatArrowBorderWidth;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.chatArrowBorderColor.CGColor);
    CGContextSetLineWidth(context, self.chatArrowBorderWidth);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat arrowWidth  = bubbleArrowWidth;
    CGFloat arrowHeight = bubbleArrowHeight;
    CGFloat viewWidth   = CGRectGetWidth(rect);
    CGFloat viewHeight  = CGRectGetHeight(rect);
    CGFloat viewCornerRaidus    = mediaArrowViewCornerRadius;
    CGFloat viewNeckHeight      = mediaArrowViewNeckHeight;
    
    switch (self.chatCellSide) {
        case HZChatCellSideOtherSide:
        {
            //other party side
            if (self.hz_fillColor) {
                CGContextSetFillColorWithColor(context, self.hz_fillColor.CGColor);
            }else {
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            }
            
            CGPathMoveToPoint(path, NULL, arrowWidth, arrowHeight + viewCornerRaidus + viewNeckHeight);
            CGPathAddLineToPoint(path, NULL, 0, viewCornerRaidus + viewNeckHeight + arrowHeight/2.0);
            CGPathAddLineToPoint(path, NULL, arrowWidth, viewCornerRaidus + viewNeckHeight);
            CGPathAddLineToPoint(path, NULL, arrowWidth, viewCornerRaidus);
            CGPathAddArcToPoint(path, NULL, arrowWidth, 0, arrowWidth + viewCornerRaidus, 0, arrowWidth);
            CGPathAddLineToPoint(path, NULL, viewWidth - viewCornerRaidus, 0);
            CGPathAddArcToPoint(path, NULL, viewWidth, 0, viewWidth, viewCornerRaidus, viewCornerRaidus);
            CGPathAddLineToPoint(path, NULL, viewWidth, viewHeight - viewCornerRaidus);
            CGPathAddArcToPoint(path, NULL, viewWidth, viewHeight, viewWidth - viewCornerRaidus, viewHeight, viewCornerRaidus);
            CGPathAddLineToPoint(path, NULL, arrowWidth + viewCornerRaidus, viewHeight);
            CGPathAddArcToPoint(path, NULL, arrowWidth, viewHeight, arrowWidth, viewHeight - viewCornerRaidus, viewCornerRaidus);
        }
            break;
        case HZChatCellSideMySide:
        {
           //my side
            if (self.hz_fillColor) {
                CGContextSetFillColorWithColor(context, self.hz_fillColor.CGColor);
            }else {
                CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            }
            
            CGPathMoveToPoint(path, NULL, viewWidth - arrowWidth, arrowHeight + viewCornerRaidus + viewNeckHeight);
            CGPathAddLineToPoint(path, NULL, viewWidth, viewCornerRaidus + viewNeckHeight + arrowHeight/2.0);
            CGPathAddLineToPoint(path, NULL, viewWidth - arrowWidth, viewCornerRaidus + viewNeckHeight);
            CGPathAddLineToPoint(path, NULL, viewWidth - arrowWidth, viewCornerRaidus);
            CGPathAddArcToPoint(path, NULL, viewWidth - arrowWidth, 0, viewWidth - (arrowWidth + viewCornerRaidus), 0, arrowWidth);
            CGPathAddLineToPoint(path, NULL, viewCornerRaidus, 0);
            CGPathAddArcToPoint(path, NULL, 0, 0, 0, viewCornerRaidus, viewCornerRaidus);
            CGPathAddLineToPoint(path, NULL, 0, viewHeight - viewCornerRaidus);
            CGPathAddArcToPoint(path, NULL, 0, viewHeight, viewCornerRaidus, viewHeight, viewCornerRaidus);
            CGPathAddLineToPoint(path, NULL, viewWidth - viewCornerRaidus - arrowWidth, viewHeight);
            CGPathAddArcToPoint(path, NULL, viewWidth - arrowWidth, viewHeight, viewWidth - arrowWidth, viewHeight - viewCornerRaidus, viewCornerRaidus);
        }
            break;
            
        default:
            break;
    }
    
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CFRelease(path);
}


@end
