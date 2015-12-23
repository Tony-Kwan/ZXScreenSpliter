//
//  ZXGlobalHotKeyMonitor.m
//  MacDemo
//
//  Created by pygzx on 15/12/22.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXGlobalHotKeyMonitor.h"
#import <Carbon/Carbon.h>
#import "AppDelegate.h"

@interface ZXGlobalHotKeyMonitor()

@end

@implementation ZXGlobalHotKeyMonitor

- (instancetype) init {
    if(self = [super init]) {
        EventTypeSpec eventType;
        eventType.eventClass = kEventClassKeyboard;
        eventType.eventKind = kEventHotKeyPressed;
        InstallApplicationEventHandler(&hotKeyHandler, 1, &eventType, (__bridge void *)self, NULL);
    
        for (NSString *hotKey in [[self hotKeyToKeyCodeMapper] allKeys]) {
            [self registerHotKey:hotKey];
        }
    }
    return self;
}

- (void) registerHotKey:(NSString*)hotKey {
    hotKey = [hotKey uppercaseString];
    NSNumber *hotKeyIndex = [[self hotKeyToIndexMapper] objectForKey:hotKey];
    NSNumber *hotKeyCode = [[self hotKeyToKeyCodeMapper] objectForKey:hotKey];
    if(hotKeyIndex && hotKeyCode) {
        EventHotKeyRef HotKeyRef;
        EventHotKeyID HotKeyID;
        HotKeyID.signature = (UInt32)[hotKeyIndex unsignedIntValue];
        HotKeyID.id = (UInt32)[hotKeyIndex unsignedIntValue];  //index 作 id
        RegisterEventHotKey([hotKeyCode unsignedIntValue], controlKey, HotKeyID, GetApplicationEventTarget(), 0, &HotKeyRef);
    }
}

- (NSDictionary*) hotKeyToIndexMapper {
    return @{
             @"Q" : @(0),
             @"W" : @(1),
             @"E" : @(2),
             @"A" : @(3),
             @"S" : @(4),
             @"D" : @(5),
             @"Z" : @(6),
             @"X" : @(7),
             @"C" : @(8),
             };
}

- (NSDictionary*) hotKeyToKeyCodeMapper {
    return @{
             @"Q" : @(kVK_ANSI_Q),
             @"W" : @(kVK_ANSI_W),
             @"E" : @(kVK_ANSI_E),
             @"A" : @(kVK_ANSI_A),
             @"S" : @(kVK_ANSI_S),
             @"D" : @(kVK_ANSI_D),
             @"Z" : @(kVK_ANSI_Z),
             @"X" : @(kVK_ANSI_X),
             @"C" : @(kVK_ANSI_C),
             };
}

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
    EventHotKeyID hotKeyRef;
    GetEventParameter(anEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(hotKeyRef), NULL, &hotKeyRef);
    
    unsigned int hotKeyId = hotKeyRef.id;
//    NSLog(@"%zd", hotKeyId);
    ZXGlobalHotKeyMonitor *hotKeyMgr = (__bridge ZXGlobalHotKeyMonitor*)userData;
    if(hotKeyMgr.onHotKeyPressed) {
        __block NSString *pressedKey;
        [[hotKeyMgr hotKeyToIndexMapper] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL * _Nonnull stop) {
            if(hotKeyId == [obj unsignedIntValue]) {
                *stop = YES;
                pressedKey = key;
            }
        }];
        if(pressedKey) {
            hotKeyMgr.onHotKeyPressed(pressedKey, [[[hotKeyMgr hotKeyToIndexMapper] objectForKey:pressedKey] unsignedIntValue]);
        }
    }
    
    return noErr;
}

@end
