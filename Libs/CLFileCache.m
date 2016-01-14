//
//  CLFileCache.m
//  auto-layout
//
//  Created by mclkyo on 15/7/26.
//  Copyright (c) 2015年 mclkyo. All rights reserved.
//

#import "CLFileCache.h"

#import <mach/mach.h>
#import <mach/mach_host.h>




static CLFileCache *ImageInstance;
static CLFileCache *FileInstance;

@implementation CLFileCache

+ (CLFileCache *)sharedImageCache
{
    if (ImageInstance == nil)
    {
        ImageInstance = [[CLFileCache alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:ImageInstance selector:@selector(memoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return ImageInstance;
}

+ (CLFileCache *)sharedFileCache
{
    if (FileInstance == nil)
    {
        FileInstance = [[CLFileCache alloc] init];
    }
    return FileInstance;
}


- (void)memoryWarning:(NSNotification*)note {
    [memCache removeAllObjects];
}


-(id)init{
    if ((self = [super init]))
    {
        memCache = [[NSMutableDictionary alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"CLFileCache"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        cacheInQueue = [[NSOperationQueue alloc]init];
        cacheInQueue.maxConcurrentOperationCount = 5;
        
        cacheOutQueue = [[NSOperationQueue alloc]init];
        cacheOutQueue.maxConcurrentOperationCount = 5;
        
        NSLog(@"%@",diskCachePath);
        
    }
    
    return self;
}


-(NSString*)getSavePath:(NSString*)key{
    return [diskCachePath stringByAppendingPathComponent:key];
}


-(NSString*)getSavePathWithFileData:(FileData *)fileData{
    if([[fileData.Url lowercaseString]  hasPrefix:@"http://"] || [[fileData.Url lowercaseString]  hasPrefix:@"https://"]){
        return [diskCachePath stringByAppendingPathComponent:fileData.Key];
    }
    else{
        return fileData.Url;
    }
}


-(void)storeKeyWithDataToDisk:(FileData *)filedata{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    [fileManager createFileAtPath:[self getSavePath:filedata.Key] contents:filedata.Data attributes:nil];
}


-(void)storeImage:(FileData *)filedata DownloadImage:(UIImage *)image{
    [memCache setObject:image forKey:filedata.Key];    
    [cacheInQueue addOperationWithBlock:^{
        [self storeKeyWithDataToDisk:filedata];
    }];
}


-(void)queryDiskImageCache:(FileData *)filedata Result:(id<CLFileCacheDelegate>)delegate downloadInfo:(NSDictionary*)info{
    
    NSLog(@"now memcache count is:%u",memCache.count);
    
    UIImage *image = [memCache objectForKey:filedata.Key];
    if (image)
    {
        // ...notify delegate immediately, no need to go async
        if ([delegate respondsToSelector:@selector(CLFileCache:ImageDidFound:downloadInfo:)])
        {
            [delegate CLFileCache:self ImageDidFound:image downloadInfo:info];
        }
        return;
    }
    
    [cacheOutQueue addOperationWithBlock:^{
        
        UIImage *imageOnDisk = [UIImage imageWithData:[NSData dataWithContentsOfFile:[self getSavePathWithFileData:filedata]]];
        NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
        [result setObject:filedata forKey:@"FileData"];
        if(imageOnDisk!=nil)
            [result setObject:imageOnDisk forKey:@"imageOnDisk"];
        [result setObject:delegate forKey:@"delegate"];
        [result setObject:info forKey:@"DownloadInfo"];
        [self performSelectorOnMainThread:@selector(NodifyDelegate:) withObject:result waitUntilDone:NO];
    }];
}


-(void)NodifyDelegate:(NSMutableDictionary*)result{
    UIImage *imageOnDisk = [result objectForKey:@"imageOnDisk"];
    FileData *fileData = [result objectForKey:@"FileData"];
    id<CLFileCacheDelegate> delegate = [result objectForKey:@"delegate"];
    NSDictionary *DownloadInfo = [result objectForKey:@"DownloadInfo"];
    
    if(imageOnDisk!=nil){
        [memCache setObject:imageOnDisk forKey:fileData.Key];
        if ([delegate respondsToSelector:@selector(CLFileCache:ImageDidFound:downloadInfo:)])
        {
            [delegate CLFileCache:self ImageDidFound:imageOnDisk downloadInfo:DownloadInfo];
        }
    }
    else{
        if([delegate respondsToSelector:@selector(CLFileCache:ImageDidNotFound:downloadInfo:)])
        {
            [delegate CLFileCache:self ImageDidNotFound:fileData downloadInfo:DownloadInfo];
        }        
    }
    
}


-(void)queryDiskFileCache:(FileData *)filedata Result:(id<CLFileCacheDelegate>)delegate downloadInfo:(NSDictionary *)info{
    
    NSData *FileData = [NSData dataWithContentsOfFile:[self getSavePathWithFileData:filedata]];
    if(FileData != nil){
        
        if([delegate respondsToSelector:@selector(CLFileCache:FileDidFound:downloadInfo:)]){
            [delegate CLFileCache:self FileDidFound:FileData downloadInfo:info];
        }
        
    }
    else{
        if([delegate respondsToSelector:@selector(CLFileCache:FileDidNotFound:downloadInfo:)])
        {
            [delegate CLFileCache:self FileDidNotFound:filedata downloadInfo:info];
        }
    }
    
    
}


-(void)storeFile:(FileData *)filedata DownloadFile:(NSData *)data{
    [cacheInQueue addOperationWithBlock:^{
        [self storeKeyWithDataToDisk:filedata];
    }];
}


-(void)storeFile:(FileData *)filedata DownloadFile:(NSData *)data Callback:(StoreFileCallback)callback{
    [cacheInQueue addOperationWithBlock:^{
        [self storeKeyWithDataToDisk:filedata];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           callback();
        });
        
    }];
}




@end
