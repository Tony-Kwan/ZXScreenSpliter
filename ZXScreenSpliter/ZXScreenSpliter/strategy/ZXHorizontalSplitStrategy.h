//
//  ZXHorizontalSplitStrategy.h
//  MacDemo
//
//  Created by PYgzx on 15/12/22.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXScreenSplitStrategy.h"

@interface ZXHorizontalSplitStrategy : NSObject <ZXScreenSplitStrategy>

@property (nonatomic, assign, getter=isToLeft) BOOL toLeft;

@end
