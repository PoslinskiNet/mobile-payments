//
//  PMItem.m
//  VoucherMill
//
//  Created by PayMill on 1/24/13.
//  Copyright (c) 2013 Paymill. All rights reserved.
//

#import "PMItem.h"

@implementation PMItem

@synthesize itemName, description;

-(id)initItem:(NSString *)aItemName description:(NSString *)aDescription value:(int)val{
    self = [super init];
    if(self)
    {
        self.itemName = aItemName;
        self.description = aDescription;
        self.value = val;
    }
    return self;
}

@end
