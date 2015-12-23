//
//  ZXScreenSpliter.m
//  MacDemo
//
//  Created by pygzx on 15/12/21.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXScreenSpliter.h"

#import <Cocoa/Cocoa.h>

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
    AXUIElementRef focusWindowRef;
    AXError err = AXUIElementCopyAttributeValue(ref, kAXFocusedWindowAttribute, (CFTypeRef*)&focusWindowRef);
    if(err) {
        return NULL;
    }
    return focusWindowRef;
    
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

#pragma mark - getter
- (NSMutableDictionary*) appDict {
    if(_appDict==nil) {
        _appDict = [NSMutableDictionary dictionary];
    }
    return _appDict;
}

@end
