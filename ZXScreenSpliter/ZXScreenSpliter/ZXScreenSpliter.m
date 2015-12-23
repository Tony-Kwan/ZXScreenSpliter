//
//  ZXScreenSpliter.m
//  MacDemo
//
//  Created by pygzx on 15/12/21.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXScreenSpliter.h"

#import <Cocoa/Cocoa.h>

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

#pragma mark - private method
- (AXUIElementRef) getTopWindowRef {
    NSRunningApplication *app = [[NSWorkspace sharedWorkspace] frontmostApplication];
    AXUIElementRef ref = AXUIElementCreateApplication([app processIdentifier]);
    CFArrayRef windowArray;
    AXUIElementCopyAttributeValue(ref, kAXWindowsAttribute, (CFTypeRef*)&windowArray);
    if(windowArray == NULL || CFArrayGetCount(windowArray)==0) {
        return NULL;
    }
    AXUIElementRef windowRef = (AXUIElementRef)CFArrayGetValueAtIndex(windowArray, 0);
    return windowRef;
}

#pragma mark - getter
- (NSMutableDictionary*) appDict {
    if(_appDict==nil) {
        _appDict = [NSMutableDictionary dictionary];
    }
    return _appDict;
}

@end
