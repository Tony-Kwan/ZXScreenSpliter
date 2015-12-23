//
//  ViewController.m
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import "ViewController.h"

#import "ZXScreenSpliter.h"
#import "ZXGlobalHotKeyMonitor.h"

#import "ZXFullScreenSplitStrategy.h"   //1X1
#import "ZXHorizontalSplitStrategy.h"   //1X2
#import "ZXVerticalSplitStrategy.h"     //2X1
#import "ZXQuarterSplitStrategy.h"      //2X2
#import "ZXSuDoKuSplitStrategy.h"       //3X3

@interface ViewController ()
@property (nonatomic, strong) ZXScreenSpliter *screenSpliter;
@property (nonatomic, strong) ZXGlobalHotKeyMonitor *hotKeyMonitor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenSpliter = [[ZXScreenSpliter alloc] init];
    
    self.hotKeyMonitor = [[ZXGlobalHotKeyMonitor alloc] init];
    
    __weak typeof (&*self) weakSelf = self;
    [self.hotKeyMonitor setOnHotKeyPressed:^(NSString *hotKey, unsigned int hotKeyIndex) {
        NSLog(@"%@ %zd", hotKey, hotKeyIndex);
        
        id<ZXScreenSplitStrategy> splitStrategy = [weakSelf createNormalStrategyWithIndex:hotKeyIndex];
        if(splitStrategy != nil) {
            [weakSelf splitScreenWithSplitStrategy:splitStrategy];
        }
    }];
}

- (void) splitScreenWithSplitStrategy:(id<ZXScreenSplitStrategy>)strategy {
    CGRect dstFrame = [strategy calculateDstFrame];
    NSLog(@"dstFrame = %@  visiableFrame = %@  ScreenFrame = %@  moveSucc = %d   meunBarHeight = %f", NSStringFromRect(dstFrame), NSStringFromRect([NSScreen mainScreen].visibleFrame), NSStringFromRect([NSScreen mainScreen].frame), [self.screenSpliter moveTopWindowToFrame:dstFrame], [[[NSApplication sharedApplication] mainMenu] menuBarHeight]);
    NSLog(@"----------------------------------------");
}

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

@end
