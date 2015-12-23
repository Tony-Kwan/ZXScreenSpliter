//
//  ZXHorizontalSplitStrategy.m
//  MacDemo
//
//  Created by PYgzx on 15/12/22.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXHorizontalSplitStrategy.h"

@implementation ZXHorizontalSplitStrategy

- (CGRect) calculateDstFrame {
    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    CGFloat dstwidth = floor(frame.size.width/2.f);
    CGRect dstFrame = frame;
    dstFrame.size.width = dstwidth;
    if(self.isToLeft == NO) {
        dstFrame.origin.x = (frame.origin.x + frame.size.width) - dstwidth;
    }
    dstFrame.origin.y = 0;
    return dstFrame;
}

@end
