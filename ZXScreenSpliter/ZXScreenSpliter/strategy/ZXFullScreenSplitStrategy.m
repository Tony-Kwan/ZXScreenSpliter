//
//  ZXFullScreenSplitStrategy.m
//  MacDemo
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXFullScreenSplitStrategy.h"

@implementation ZXFullScreenSplitStrategy

- (CGRect) calculateDstFrame {
    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    frame.origin.y = 23;
    return frame;
}

@end
