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

#define ZXHotKeyMapperStoreKey @"HotKeyMapperStoreKey"

@interface ZXGlobalHotKeyMonitor()
@property (nonatomic, strong) NSMutableDictionary *hotKeyToIndexMapper;
@property (nonatomic, strong) NSMutableDictionary *hotKeyRefDict;
@end

@implementation ZXGlobalHotKeyMonitor

#pragma mark - static method
+ (NSDictionary*) hotKeyToKeyCodeMapper {
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
             
             @"R" : @(kVK_ANSI_R),
             @"T" : @(kVK_ANSI_T),
             @"Y" : @(kVK_ANSI_Y),
             @"F" : @(kVK_ANSI_F),
             @"G" : @(kVK_ANSI_G),
             @"H" : @(kVK_ANSI_H),
             @"V" : @(kVK_ANSI_V),
             @"B" : @(kVK_ANSI_B),
             @"N" : @(kVK_ANSI_N),
             
             @"U" : @(kVK_ANSI_U),
             @"I" : @(kVK_ANSI_I),
             @"O" : @(kVK_ANSI_O),
             @"J" : @(kVK_ANSI_J),
             @"K" : @(kVK_ANSI_K),
             @"L" : @(kVK_ANSI_L),
             @"M" : @(kVK_ANSI_M),
             @"," : @(kVK_ANSI_Comma),
             @"." : @(kVK_ANSI_Period),
             
             @"0" : @(kVK_ANSI_0),
             @"1" : @(kVK_ANSI_1),
             @"2" : @(kVK_ANSI_2),
             @"3" : @(kVK_ANSI_3),
             @"4" : @(kVK_ANSI_4),
             @"5" : @(kVK_ANSI_5),
             @"6" : @(kVK_ANSI_6),
             @"7" : @(kVK_ANSI_7),
             @"8" : @(kVK_ANSI_8),
             @"9" : @(kVK_ANSI_9),
             
//             @" " : @(kVK_Space),
             };
}

+ (NSArray<NSString*>*) acceptHotKey {
    return [[self hotKeyToKeyCodeMapper] allKeys];
}

#pragma mark -
- (instancetype) init {
    if(self = [super init]) {
        [self readHotKeyMapper];
        
        EventTypeSpec eventType;
        eventType.eventClass = kEventClassKeyboard;
        eventType.eventKind = kEventHotKeyPressed;
        InstallApplicationEventHandler(&hotKeyHandler, 1, &eventType, (__bridge void *)self, NULL);
    
        self.hotKeyRefDict = [NSMutableDictionary dictionaryWithCapacity:9];
        for (NSString *hotKey in [[ZXGlobalHotKeyMonitor hotKeyToKeyCodeMapper] allKeys]) {
            [self registerWithHotKey:hotKey hotKeyIndex:[[self hotKeyToIndexMapper] objectForKey:hotKey]];
        }
    }
    return self;
}

- (BOOL) registerWithHotKey:(NSString*)hotKey hotKeyIndex:(NSNumber*)hotKeyIndex {
    if(hotKeyIndex==nil || [hotKeyIndex unsignedIntValue] > 8) return NO;
    
    hotKey = [hotKey uppercaseString];
    NSNumber *hotKeyCode = [[ZXGlobalHotKeyMonitor hotKeyToKeyCodeMapper] objectForKey:hotKey];
    if(hotKeyIndex && hotKeyCode) {
        EventHotKeyRef hotKeyRef;
        EventHotKeyID HotKeyID;
        HotKeyID.signature = (UInt32)[hotKeyIndex unsignedIntValue];
        HotKeyID.id = (UInt32)[hotKeyIndex unsignedIntValue];  //index 作 id
        OSStatus status = RegisterEventHotKey([hotKeyCode unsignedIntValue], controlKey, HotKeyID, GetApplicationEventTarget(), 0, &hotKeyRef);

        if(status == 0) {
            [self.hotKeyRefDict setObject:[NSValue valueWithPointer:(const void*)hotKeyRef] forKey:hotKeyIndex];
            return YES;
        }
    }
    return NO;
}

- (BOOL) mapHotKey:(NSString*)hotKey toIndex:(unsigned int)index {
    NSLog(@"Map HotKey : %@ --> %zd", hotKey, index);
    if(hotKey == nil || index > 8) return NO;
    
    __block NSString *oldHotKey = nil;
    [self.hotKeyToIndexMapper enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull key, NSNumber* _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj unsignedIntValue] == index) {
            *stop = YES;
            oldHotKey = key;
        }
    }];

    if(oldHotKey == nil) return NO;
    
    [self.hotKeyToIndexMapper removeObjectForKey:oldHotKey];
    [self.hotKeyToIndexMapper setObject:@(index) forKey:hotKey];
    
    EventHotKeyRef hotKeyRef = (__bridge EventHotKeyRef)([self.hotKeyRefDict objectForKey:@(index)]);
    UnregisterEventHotKey(hotKeyRef);
    
    BOOL succ = [self registerWithHotKey:hotKey hotKeyIndex:@(index)];
    if(succ == NO) {
        return NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:self.hotKeyToIndexMapper] forKey:ZXHotKeyMapperStoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (void) readHotKeyMapper {
#ifdef DEBUG
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ZXHotKeyMapperStoreKey];
#endif
    NSDictionary *hotKeymapper = [[NSUserDefaults standardUserDefaults] objectForKey:ZXHotKeyMapperStoreKey];
    if(hotKeymapper == nil) {
        hotKeymapper = @{
                         @"Q" : @(0),
                         @"W" : @(1),
                         @"E" : @(2),
                         @"A" : @(3),
                         @"S" : @(4),
                         @"D" : @(5),
                         @"Z" : @(6),
                         @"X" : @(7),
                         @"V" : @(8),
                         };
    }
    self.hotKeyToIndexMapper = [hotKeymapper mutableCopy];
}

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
    EventHotKeyID hotKeyRef;
    GetEventParameter(anEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(hotKeyRef), NULL, &hotKeyRef);
    
    unsigned int hotKeyId = hotKeyRef.id;
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
