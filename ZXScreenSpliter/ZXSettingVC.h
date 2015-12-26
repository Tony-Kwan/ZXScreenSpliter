//
//  ZXSettingVC.h
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/24.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZXScreenSpliter.h"
#import "ZXGlobalHotkeyMonitor.h"

@interface ZXSettingVC : NSViewController

@property (nonatomic, weak) ZXScreenSpliter *screenSpliter;
@property (nonatomic, weak) ZXGlobalHotKeyMonitor *hotKeyMonitor;

@end
