//
//  ZXQuarterSplitStrategy.h
//  MacDemo
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXScreenSplitStrategy.h"

@interface ZXQuarterSplitStrategy : NSObject <ZXScreenSplitStrategy>

/**
 |-------|
 | 0 | 1 |
 |-------|
 | 2 | 3 |
 |-------|
 */
@property (nonatomic, assign) unsigned int toIndex;


@end
