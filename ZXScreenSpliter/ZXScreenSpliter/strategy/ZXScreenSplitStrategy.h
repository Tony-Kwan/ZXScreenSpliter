//
//  ZXScreenSplitStrategy.h
//  MacDemo
//
//  Created by PYgzx on 15/12/22.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#ifndef ZXScreenSplitStrategy_h
#define ZXScreenSplitStrategy_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@protocol ZXScreenSplitStrategy <NSObject>
@required
- (CGRect) calculateDstFrame;

@end

#endif /* ZXScreenSplitStrategy_h */
