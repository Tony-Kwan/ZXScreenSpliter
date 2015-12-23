//
//  ZXSuDoKuSplitStrategy.m
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXSuDoKuSplitStrategy.h"

@implementation ZXSuDoKuSplitStrategy

- (CGRect) calculateDstFrame {
    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    frame.origin.y = 23;
    if(self.toIndex > 8) return frame;
    
    CGFloat thirdWidth = floor(frame.size.width/3.f);
    CGFloat thirdHeight = floor(frame.size.height/3.f);
    frame.origin.x = (self.toIndex % 3) * thirdWidth;
    frame.origin.y = (self.toIndex / 3) * thirdHeight + 23;
    frame.size = CGSizeMake(thirdWidth, thirdHeight);
    return frame;
}

@end
