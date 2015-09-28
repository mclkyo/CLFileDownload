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

static unsigned long get_free_memory(void)
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
    {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    
    /* Stats in bytes */
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}


static CLFileCache *ImageInstance;
static CLFileCache *FileInstance;

@implementation CLFileCache

+ (CLFileCache *)sharedImageCache
{
    if (ImageInstance == nil)
    {
        ImageInstance = [[CLFileCache alloc] init];
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
        cacheInQueue.maxConcurrentOperationCount = 1;
        
        cacheOutQueue = [[NSOperationQueue alloc]init];
        cacheOutQueue.maxConcurrentOperationCount = 1;
        
        NSLog(@"%@",diskCachePath);
        
    }
    
    return self;
}

-(NSString*)getSavePath:(NSString*)key{
    return [diskCachePath stringByAppendingPathComponent:key];
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
        
        UIImage *imageOnDisk = [UIImage imageWithData:[NSData dataWithContentsOfFile:[self getSavePath:filedata.Key]]];
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
    
    NSData *FileData = [NSData dataWithContentsOfFile:[self getSavePath:filedata.Key]];
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
