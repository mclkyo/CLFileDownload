//
//  CLFileCache.h
//  auto-layout
//
//  Created by mclkyo on 15/7/26.
//  Copyright (c) 2015年 mclkyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CLFileCacheDelegate.h"
#import "FileData.h"

typedef void (^StoreFileCallback)();

@interface CLFileCache : NSObject{
    NSMutableDictionary *memCache;
    NSString *diskCachePath;
    NSOperationQueue *cacheInQueue,*cacheOutQueue;
}

+ (CLFileCache *)sharedImageCache;
+ (CLFileCache *)sharedFileCache;
 
-(void)queryDiskImageCache:(FileData*)filedata Result:(id<CLFileCacheDelegate>)delegate downloadInfo:(NSDictionary*)info;
-(void)storeImage:(FileData *)filedata DownloadImage:(UIImage*)image;


-(void)queryDiskFileCache:(FileData*)filedata Result:(id<CLFileCacheDelegate>)delegate downloadInfo:(NSDictionary*)info;

-(void)storeFile:(FileData*)filedata DownloadFile:(NSData*)data;
-(void)storeFile:(FileData *)filedata DownloadFile:(NSData *)data Callback:(StoreFileCallback)callback;;


-(NSString*)getSavePathWithFileData:(FileData*)fileData;

@end
