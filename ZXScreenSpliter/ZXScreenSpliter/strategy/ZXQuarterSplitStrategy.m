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
    
    CGFloat halfWidth = floor(CGRectGetWidth(frame)/2.f);
    CGFloat halfHeight = floor(CGRectGetHeight(frame)/2.f);
    frame.origin.x += (self.toIndex % 2) * halfWidth;
    frame.origin.y = (self.toIndex / 2) * halfHeight + 23;
    frame.size.width = halfWidth;
    frame.size.height = halfHeight;
    return frame;
}

@end
