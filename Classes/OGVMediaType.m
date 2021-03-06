//
//  OGVMediaType.m
//  OGVKit
//
//  Created by Brion on 6/21/2015.
//  Copyright (c) 2015 Brion Vibber. All rights reserved.
//

#import "OGVKit.h"

static NSString *trim(NSString *str)
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

static void split(NSString *str, NSString *separator, NSString **first, NSString **second)
{
    NSRange sep = [str rangeOfString:separator];
    if (sep.location == NSNotFound) {
        *first = trim(str);
        *second = nil;
    } else {
        *first = trim([str substringToIndex:sep.location]);
        *second = trim([str substringFromIndex:sep.location + sep.length]);
    }
}

@implementation OGVMediaType

- (instancetype)initWithMajor:(NSString *)major minor:(NSString *)minor codecs:(NSArray *)codecs
{
    self = [super init];
    if (self) {
        _major = [major copy];
        _minor = [minor copy];
        _codecs = codecs ? [NSArray arrayWithArray:codecs] : nil;
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string
{
    NSString *base = nil;
    NSString *extra = nil;
    split(string, @";", &base, &extra);
    
    NSString *major = nil;
    NSString *minor = nil;
    split(base, @"/", &major, &minor);
    
    // @todo parse the codecs from the extra info
    NSArray *codecs = nil;

    return [self initWithMajor:major minor:minor codecs:codecs];
}

- (instancetype)initWithFileName:(NSString *)fileName
{
    NSString *mineTypeGess = nil;
    
    NSString *fileExtension = [fileName pathExtension];
    if ([fileExtension isEqualToString:@"webm"]) {
        mineTypeGess = @"video/webm";
    }else if ([fileExtension isEqualToString:@"ogg"]){
        mineTypeGess = @"application/ogg";
    }else if ([fileExtension isEqualToString:@"ogv"]){
        mineTypeGess = @"application/ogg";
    }else if ([fileExtension isEqualToString:@"oga"]){
        mineTypeGess = @"application/ogg";
    }else if ([fileExtension isEqualToString:@"ogx"]){
        mineTypeGess = @"application/ogg";
    }else if ([fileExtension isEqualToString:@"ogm"]){
        mineTypeGess = @"application/ogg";
    }
    
    return [self initWithString:mineTypeGess];
}
@end
