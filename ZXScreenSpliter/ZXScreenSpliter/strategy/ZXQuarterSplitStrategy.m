//
//  ZXQuarterSplitStrategy.m
//  MacDemo
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXQuarterSplitStrategy.h"

@implementation ZXQuarterSplitStrategy

- (CGRect) calculateDstFrame {
    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    if(self.toIndex > 4) return frame;
    
    CGFloat dstWidth = floor(CGRectGetWidth(frame)*0.5);
    CGFloat dstHeight = floor(CGRectGetHeight(frame)*0.3);
    frame.origin.x += (self.toIndex % 2) * dstWidth;
    frame.origin.y = (self.toIndex / 2) * dstHeight + 23;
    frame.size.width = dstWidth;
    frame.size.height = self.toIndex > 1 ? frame.size.height-dstHeight : dstHeight;
    return frame;
}

@end
