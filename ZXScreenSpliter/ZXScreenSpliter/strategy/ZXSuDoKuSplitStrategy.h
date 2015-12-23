//
//  ZXSuDoKuSplitStrategy.h
//  ZXScreenSpliter
//
//  Created by pygzx on 15/12/23.
//  Copyright © 2015年 pygzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXScreenSplitStrategy.h"

@interface ZXSuDoKuSplitStrategy : NSObject <ZXScreenSplitStrategy>

/**
 +-----------+
 | 0 | 1 | 2 |
 |-----------|
 | 3 | 4 | 5 |
 |-----------|
 | 6 | 7 | 8 |
 +-----------+
 */
@property (nonatomic, assign) unsigned int toIndex;

@end
