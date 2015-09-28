//
//  CLImageCacheDelegate.h
//  auto-layout
//
//  Created by mclkyo on 15/7/27.
//  Copyright (c) 2015年 mclkyo. All rights reserved.
//

@class CLFileCache;
@class FileData;

@protocol CLFileCacheDelegate <NSObject>

@optional

-(void)CLFileCache:(CLFileCache*)cache ImageDidFound:(UIImage*)image downloadInfo:(NSDictionary*)info;
-(void)CLFileCache:(CLFileCache*)cache ImageDidNotFound:(FileData*)data downloadInfo:(NSDictionary*)info;

-(void)CLFileCache:(CLFileCache*)cache FileDidFound:(NSData*)data downloadInfo:(NSDictionary*)info;
-(void)CLFileCache:(CLFileCache*)cache FileDidNotFound:(FileData*)data downloadInfo:(NSDictionary*)info;


@end
