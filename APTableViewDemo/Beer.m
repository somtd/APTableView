//
//  Beer.m
//  APTableViewDemo
//
//  Created by SOMTD on 2013/07/30.
//  Copyright (c) 2013年 SOMTD. All rights reserved.
//

#import "Beer.h"

@implementation Beer

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name    = dictionary[@"name"];
        self.brewery = dictionary[@"brewery"][@"name"];
    }
    return self;
}
@end
