//
//  ZXGlobalHotKeyMonitor.h
//  MacDemo
//
//  Created by pygzx on 15/12/22.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    kVK_ANSI_A                    = 0x00,
//    kVK_ANSI_S                    = 0x01,
//    kVK_ANSI_D                    = 0x02,
//    kVK_ANSI_F                    = 0x03,
//    kVK_ANSI_H                    = 0x04,
//    kVK_ANSI_G                    = 0x05,
//    kVK_ANSI_Z                    = 0x06,
//    kVK_ANSI_X                    = 0x07,
//    kVK_ANSI_C                    = 0x08,
//    kVK_ANSI_V                    = 0x09,
//    kVK_ANSI_B                    = 0x0B,
//    kVK_ANSI_Q                    = 0x0C,
//    kVK_ANSI_W                    = 0x0D,
//    kVK_ANSI_E                    = 0x0E,
//    kVK_ANSI_R                    = 0x0F,
//    kVK_ANSI_Y                    = 0x10,
//    kVK_ANSI_T                    = 0x11,
//    kVK_ANSI_1                    = 0x12,
//    kVK_ANSI_2                    = 0x13,
//    kVK_ANSI_3                    = 0x14,
//    kVK_ANSI_4                    = 0x15,
//    kVK_ANSI_6                    = 0x16,
//    kVK_ANSI_5                    = 0x17,
//    kVK_ANSI_Equal                = 0x18,
//    kVK_ANSI_9                    = 0x19,
//    kVK_ANSI_7                    = 0x1A,
//    kVK_ANSI_Minus                = 0x1B,
//    kVK_ANSI_8                    = 0x1C,
//    kVK_ANSI_0                    = 0x1D,
//    kVK_ANSI_RightBracket         = 0x1E,
//    kVK_ANSI_O                    = 0x1F,
//    kVK_ANSI_U                    = 0x20,
//    kVK_ANSI_LeftBracket          = 0x21,
//    kVK_ANSI_I                    = 0x22,
//    kVK_ANSI_P                    = 0x23,
//    kVK_ANSI_L                    = 0x25,
//    kVK_ANSI_J                    = 0x26,
//    kVK_ANSI_Quote                = 0x27,
//    kVK_ANSI_K                    = 0x28,
//    kVK_ANSI_Semicolon            = 0x29,
//    kVK_ANSI_Backslash            = 0x2A,
//    kVK_ANSI_Comma                = 0x2B,
//    kVK_ANSI_Slash                = 0x2C,
//    kVK_ANSI_N                    = 0x2D,
//    kVK_ANSI_M                    = 0x2E,
//    kVK_ANSI_Period               = 0x2F,
//    kVK_ANSI_Grave                = 0x32,
//    kVK_ANSI_KeypadDecimal        = 0x41,
//    kVK_ANSI_KeypadMultiply       = 0x43,
//    kVK_ANSI_KeypadPlus           = 0x45,
//    kVK_ANSI_KeypadClear          = 0x47,
//    kVK_ANSI_KeypadDivide         = 0x4B,
//    kVK_ANSI_KeypadEnter          = 0x4C,
//    kVK_ANSI_KeypadMinus          = 0x4E,
//    kVK_ANSI_KeypadEquals         = 0x51,
//    kVK_ANSI_Keypad0              = 0x52,
//    kVK_ANSI_Keypad1              = 0x53,
//    kVK_ANSI_Keypad2              = 0x54,
//    kVK_ANSI_Keypad3              = 0x55,
//    kVK_ANSI_Keypad4              = 0x56,
//    kVK_ANSI_Keypad5              = 0x57,
//    kVK_ANSI_Keypad6              = 0x58,
//    kVK_ANSI_Keypad7              = 0x59,
//    kVK_ANSI_Keypad8              = 0x5B,
//    kVK_ANSI_Keypad9              = 0x5C
//}ZXKeyCode;

@interface ZXGlobalHotKeyMonitor : NSObject

@property (nonatomic, copy) void (^onHotKeyPressed)(NSString *hotKey, unsigned int hotKeyIndex);

- (BOOL) mapHotKey:(NSString*)hotKey toIndex:(unsigned int)index;

@end
