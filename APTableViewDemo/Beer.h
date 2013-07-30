//
//  Beer.h
//  APTableViewDemo
//
//  Created by SOMTD on 2013/07/30.
//  Copyright (c) 2013年 SOMTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *brewery;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
