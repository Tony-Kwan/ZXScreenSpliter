//
//  ZXScreenSpliter.h
//  MacDemo
//
//  Created by pygzx on 15/12/21.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZXScreenSpliterMode) {
    ZXScreenSpliterMode_Normal,
    ZXScreenSpliterMode_LargeScreen,
    ZXScreenSpliterMode_Off,
};

@interface ZXScreenSpliter : NSObject

@property (nonatomic, assign) ZXScreenSpliterMode mode;

- (BOOL) moveToIndex:(unsigned int)hotKeyIndex;

//- (BOOL) moveTopWindowToFrame:(CGRect)newFrame;

@end
