//
//  FileData.m
//  auto-layout
//
//  Created by mclkyo on 15/7/26.
//  Copyright (c) 2015年 mclkyo. All rights reserved.
//

#import "FileData.h"
#import <CommonCrypto/CommonDigest.h>

@implementation FileData



- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}


-(id)initWithUrl:(NSString*)url{
    
    self = [super init];
    self.Url = url;
    self.Key = [self cachePathForKey:self.Url];
    return self;
}
@end
