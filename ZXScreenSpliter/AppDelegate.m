//
//  AppDelegate.m
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "AppDelegate.h"

#import "ZXSettingVC.h"

#import "ZXScreenSpliter.h"
#import "ZXGlobalHotKeyMonitor.h"

@interface AppDelegate ()
@property (nonatomic, strong) ZXScreenSpliter *screenSpliter;
@property (nonatomic, strong) ZXGlobalHotKeyMonitor *hotKeyMonitor;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSPopover *settingPopover;
@property (nonatomic, strong) id popoverTransiencyMonitor;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.screenSpliter = [[ZXScreenSpliter alloc] init];
    
    self.hotKeyMonitor = [[ZXGlobalHotKeyMonitor alloc] init];
    
    __weak typeof (&*self) weakSelf = self;
    [self.hotKeyMonitor setOnHotKeyPressed:^(NSString *hotKey, unsigned int hotKeyIndex) {
        BOOL succ = [weakSelf.screenSpliter moveToIndex:hotKeyIndex];
        NSLog(@"pressed key : %@   move to Index : %zd   succ = %zd", hotKey, hotKeyIndex, succ);
    }];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *icon = [NSImage imageNamed:@"statusIcon"];
    [icon setTemplate:YES];
    [self.statusItem.button setImage:icon];
    [self.statusItem.button setTarget:self];
    [self.statusItem.button setAction:@selector(onStatusItemClicked:)];
    
    ZXSettingVC *settingVC = [[ZXSettingVC alloc] initWithNibName:@"ZXSettingVC" bundle:nil];
    settingVC.screenSpliter = self.screenSpliter;
    settingVC.hotKeyMonitor = self.hotKeyMonitor;
    
    self.settingPopover = [[NSPopover alloc] init];
    self.settingPopover.contentViewController = settingVC;
    self.settingPopover.behavior = NSPopoverBehaviorTransient;
}

- (void) applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"Terminal");
}

- (void) showSettingPopover:(NSStatusBarButton*)sender {
    [self.settingPopover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
    
    if(self.popoverTransiencyMonitor == nil) {
        self.popoverTransiencyMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask|NSRightMouseDownMask handler:^(NSEvent * _Nonnull event) {
            [self hideSettingPopover:sender];
        }];
    }
}

- (void) hideSettingPopover:(NSStatusBarButton*)sender {
    [self.settingPopover performClose:sender];
    if(self.popoverTransiencyMonitor) {
        [NSEvent removeMonitor:self.popoverTransiencyMonitor];
        self.popoverTransiencyMonitor = nil;
    }
}

- (void) onStatusItemClicked:(NSStatusBarButton*)sender {
    NSLog(@"On Status Item Click");
    if(self.settingPopover.shown) {
        [self hideSettingPopover:sender];
    }
    else {
        [self showSettingPopover:sender];
    }
}


@end
