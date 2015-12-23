//
//  ZXVerticalSplitStrategy.h
//  MacDemo
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXScreenSplitStrategy.h"

@interface ZXVerticalSplitStrategy : NSObject<ZXScreenSplitStrategy>

@property (nonatomic, assign, getter=isToTop) BOOL toTop;

@end
