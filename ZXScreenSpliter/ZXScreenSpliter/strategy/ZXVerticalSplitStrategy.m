//
//  ZXVerticalSplitStrategy.m
//  MacDemo
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXVerticalSplitStrategy.h"

@implementation ZXVerticalSplitStrategy

- (CGRect) calculateDstFrame {
    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    CGFloat dstHeight = floor(frame.size.height/2.f);
    CGRect dstFrame = frame;
    dstFrame.origin.y = 23;
    dstFrame.size.height = dstHeight;
    if(self.isToTop == NO) {
        dstFrame.origin.y = (frame.origin.y + frame.size.height) - dstHeight + 23;
    }
    
    return dstFrame;
}

@end
