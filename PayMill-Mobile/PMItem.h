//
//  PMItem.h
//  VoucherMill
//
//  Created by PayMill on 1/24/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMItem : NSObject

@property (strong)NSString *itemName;
@property (strong)NSString *description;
@property (nonatomic)int value;

-(id)initItem: (NSString *)aItemName description:(NSString *)aDescription value:(int)val;

@end
