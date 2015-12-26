//
//  ZXScreenSpliter.m
//  MacDemo
//
//  Created by pygzx on 15/12/21.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXScreenSpliter.h"

#import <Cocoa/Cocoa.h>

#import "ZXFullScreenSplitStrategy.h"   //1X1
#import "ZXHorizontalSplitStrategy.h"   //1X2
#import "ZXVerticalSplitStrategy.h"     //2X1
#import "ZXQuarterSplitStrategy.h"      //2X2
#import "ZXSuDoKuSplitStrategy.h"       //3X3

#pragma mark - C method
void TestTravelArray(const void *value, void *context) {
    NSLog(@"%@", value);
}
#pragma mark



@interface ZXScreenSpliter()
@property (nonatomic, strong) NSMutableDictionary *appDict;
@end

@implementation ZXScreenSpliter

- (instancetype) init {
    if(self = [super init]) {
        
    }
    return self;
}

#pragma mark - public method
- (BOOL) moveToIndex:(unsigned int)hotKeyIndex {
    id<ZXScreenSplitStrategy> splitStrategy;
    if(self.mode == ZXScreenSpliterMode_Normal) {
        splitStrategy  = [self createNormalStrategyWithIndex:hotKeyIndex];
    }
    else if(self.mode == ZXScreenSpliterMode_LargeScreen) {
        splitStrategy = [self create3X3StrategyWithIndex:hotKeyIndex];
    }
    if(splitStrategy != nil) {
        CGRect rect = [splitStrategy calculateDstFrame];
        return [self moveTopWindowToFrame:rect];
    }
    return NO;
}

#pragma mark - private method
- (BOOL) moveTopWindowToFrame:(CGRect)newFrame {
    AXUIElementRef windowRef = [self getTopWindowRef];
    if(windowRef == NULL) {
        return NO;
    }
    CFTypeRef position = AXValueCreate(kAXValueCGPointType, (const void*)&newFrame.origin);
    CFTypeRef size = AXValueCreate(kAXValueCGSizeType, (const void*)&newFrame.size);
    
    AXError posError = AXUIElementSetAttributeValue(windowRef, kAXPositionAttribute, position);
    AXError sizeError = AXUIElementSetAttributeValue(windowRef, kAXSizeAttribute, size);
    return (posError==kAXErrorSuccess && sizeError==kAXErrorSuccess);
}

- (AXUIElementRef) getTopWindowRef {
    NSRunningApplication *app = [[NSWorkspace sharedWorkspace] frontmostApplication];
    AXUIElementRef ref = AXUIElementCreateApplication([app processIdentifier]);
    AXUIElementRef focusWindowRef;
    AXError err = AXUIElementCopyAttributeValue(ref, kAXFocusedWindowAttribute, (CFTypeRef*)&focusWindowRef);
    if(err) {
        return NULL;
    }
    if(focusWindowRef) {
        return focusWindowRef;
    }
    
    CFArrayRef windowArray;
    AXError error = AXUIElementCopyAttributeValue(ref, kAXWindowsAttribute, (CFTypeRef*)&windowArray);
    if(error || windowArray == NULL || CFArrayGetCount(windowArray) == 0) {
        return  NULL;
    }
    
    CFIndex count = CFArrayGetCount(windowArray);
    if(windowArray == NULL || count == 0) {
        return NULL;
    }
    AXUIElementRef windowRef = (AXUIElementRef)CFArrayGetValueAtIndex(windowArray, 1);
    CFArrayApplyFunction(windowArray, CFRangeMake(0, count), TestTravelArray, nil);
    return windowRef;
}

#pragma mark - strategy
- (id<ZXScreenSplitStrategy>) createNormalStrategyWithIndex:(unsigned int)index {
    id<ZXScreenSplitStrategy> strategy = nil;
    
    switch (index) {
        case 0 : {
            strategy = [[ZXQuarterSplitStrategy alloc] init];
            ((ZXQuarterSplitStrategy*)strategy).toIndex = 0;
        }
            break;
        case 1 : {
            strategy = [[ZXVerticalSplitStrategy alloc] init];
            ((ZXVerticalSplitStrategy*)strategy).toTop = YES;
        }
            break;
        case 2 : {
            strategy = [[ZXQuarterSplitStrategy alloc] init];
            ((ZXQuarterSplitStrategy*)strategy).toIndex = 1;
        }
            break;
        case 3 : {
            strategy = [[ZXHorizontalSplitStrategy alloc] init];
            ((ZXHorizontalSplitStrategy*)strategy).toLeft = YES;
        }
            break;
        case 4 : {
            strategy = [[ZXFullScreenSplitStrategy alloc] init];
        }
            break;
        case 5 : {
            strategy = [[ZXHorizontalSplitStrategy alloc] init];
            ((ZXHorizontalSplitStrategy*)strategy).toLeft = NO;
        }
            break;
        case 6 : {
            strategy = [[ZXQuarterSplitStrategy alloc] init];
            ((ZXQuarterSplitStrategy*)strategy).toIndex = 2;
        }
            break;
        case 7 : {
            strategy = [[ZXVerticalSplitStrategy alloc] init];
            ((ZXVerticalSplitStrategy*)strategy).toTop = NO;
        }
            break;
        case 8 : {
            strategy = [[ZXQuarterSplitStrategy alloc] init];
            ((ZXQuarterSplitStrategy*)strategy).toIndex = 3;
        }
            break;
        default:
            break;
    }
    return strategy;
}

- (id<ZXScreenSplitStrategy>) create3X3StrategyWithIndex:(unsigned int)index {
    ZXSuDoKuSplitStrategy *sudokuStrategy = [[ZXSuDoKuSplitStrategy alloc] init];
    sudokuStrategy.toIndex = index;
    return sudokuStrategy;
}

#pragma mark - getter
- (NSMutableDictionary*) appDict {
    if(_appDict==nil) {
        _appDict = [NSMutableDictionary dictionary];
    }
    return _appDict;
}

@end
