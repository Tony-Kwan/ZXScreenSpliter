//
//  ZXSettingVC.m
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/24.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ZXSettingVC.h"
#import "AppDelegate.h"

@interface ZXSettingVC () <NSTextFieldDelegate>
@property (nonatomic, strong) NSString *oldStringValue;
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
    sender.stringValue = [sender.stringValue substringFromIndex:sender.stringValue.length-1];
}

- (IBAction)onModeChange:(NSPopUpButton*)sender {
    if(self.screenSpliter) {
        self.screenSpliter.mode = (ZXScreenSpliterMode)sender.indexOfSelectedItem;
    }
}

- (void) controlTextDidBeginEditing:(NSNotification *)obj {
    NSTextField *textField = [obj object];
    self.oldStringValue = [textField stringValue];
//    NSLog(@"controlTextDidBeginEditing : %@", self.oldStringValue);
}

- (void) controlTextDidChange:(NSNotification *)obj {
    NSTextField *textField = [obj object];
    NSString *text = [textField stringValue];
    if(text && text.length > 0) {
        textField.stringValue = [text substringFromIndex:text.length-1];
    }
    else if(self.oldStringValue) {
        textField.stringValue = [self.oldStringValue substringFromIndex:self.oldStringValue.length-1];
    }
    else {
        textField.stringValue = @"";
    }
    textField.stringValue = [textField.stringValue uppercaseString];
    self.oldStringValue = textField.stringValue;
    
    if(textField.stringValue && textField.stringValue.length && self.hotKeyMonitor) {
        BOOL succ = [self.hotKeyMonitor mapHotKey:textField.stringValue toIndex:(unsigned int)(textField.tag-100)];
        NSLog(@"Reset Hot key Succ = %d    tag = %zd", succ, textField.tag);
    }
}

@end
