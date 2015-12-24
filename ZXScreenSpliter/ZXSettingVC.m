//
//  ZXSettingVC.m
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/24.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXSettingVC.h"
#import "AppDelegate.h"

@interface ZXSettingVC ()

@end

@implementation ZXSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onQuit:(id)sender {
    [NSApp terminate:[NSApplication sharedApplication]];
}

- (IBAction)onHotKeyFieldValueChange:(NSTextField*)sender {
    NSLog(@"%@", sender);
}

- (IBAction)onModeChange:(NSPopUpButton*)sender {
//    NSMenuItem *modeItem = [sender itemAtIndex:sender.selectedTag];
    NSLog(@"%@ %zd", sender.titleOfSelectedItem, sender.selectedTag);
}

@end
