//
//  CLImageManager.m
//  size class
//
//  Created by yilecity on 15/7/28.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import "CLImageManager.h"

static CLImageManager *instance;

@implementation CLImageManager


+(id)shareImageManager{
    
    if(instance == nil){
        instance = [[CLImageManager alloc]init];
    }
    return instance;
}


-(void)DownloadUIImage:(id<CLImageManagerDelegate>)obj ImageUrl:(NSString *)Url{
 
    [self cancelForDelegate:obj];
    [self downloadWithUrl:Url ManagerDelegate:obj];
}



-(id)init{
    if(self = [super init]){
        downloadDelegates = [[NSMutableArray alloc]init];
        downloadUrls = [[NSMutableDictionary alloc]init];
        downloaders = [[NSMutableArray alloc]init];
        downloadFileData = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSUInteger)indexOfDelegate:(id<CLImageManagerDelegate>)delegate
{
    // Do a linear search, simple (even if inefficient)
    NSUInteger idx;
    for (idx = 0; idx < [downloadDelegates count]; idx++)
    {
        if ([downloadDelegates objectAtIndex:idx] == delegate)
        {
            return idx;
        }
    }
    return NSNotFound;
}


-(void)downloadWithUrl:(NSString *)url ManagerDelegate:(id<CLImageManagerDelegate>)delegate{
    
    FileData *data = [[FileData alloc]initWithUrl:url];
    CLFileCache *cache = [CLFileCache sharedImageCache];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          delegate, @"delegate",
                          data , @"filedata",
                          nil];
    
    
    [cache queryDiskImageCache:data Result:self downloadInfo:info];
    
}


-(void)cancelForDelegate:(id<CLImageManagerDelegate>)delegate{

    NSUInteger idx;
    
    
 
    while ((idx = [downloadDelegates indexOfObjectIdenticalTo:delegate]) != NSNotFound)
    {
        [downloadDelegates removeObjectAtIndex:idx];
        
        CLFileDownload *downloader = [downloaders objectAtIndex:idx];
    
        [downloadFileData removeObjectAtIndex:idx];
        
        [downloaders removeObjectAtIndex:idx];
        
        if (![downloaders containsObject:downloader])
        {
            // No more delegate are waiting for this download, cancel it
            [downloader Cancel];
            [downloadUrls removeObjectForKey:downloader.Url];
        }
    }
}


#pragma mark FileDownloader Delegate
-(void)fileDownloader:(CLFileDownload *)download didFail:(NSError*)error{
    
    for (NSInteger idx = (NSInteger)[downloaders count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        CLFileDownload *aDownloader = [downloaders objectAtIndex:uidx];
        if (aDownloader == download)
        {
            id<CLImageManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            
            if([delegate respondsToSelector:@selector(loadImageFail:Error:)]){
                [delegate loadImageFail:self Error:error];
            }
            
            [downloadDelegates removeObject:delegate];
            [downloadFileData removeObjectAtIndex:uidx];
            [downloaders removeObjectAtIndex:uidx];
        }
    }
}

-(void)fileDownloader:(CLFileDownload *)download didFinish:(NSData *)data{
    
    for (NSInteger idx = (NSInteger)[downloaders count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        CLFileDownload *aDownloader = [downloaders objectAtIndex:uidx];
        if (aDownloader == download)
        {
            id<CLImageManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            FileData *filedata = [downloadFileData objectAtIndex:uidx];
            UIImage *image = [UIImage imageWithData:data];
            filedata.Data = data;
            
            [[CLFileCache sharedImageCache]storeImage:filedata DownloadImage:image];
            
            if([delegate respondsToSelector:@selector(loadImageDidFisish:FinishImage:)]){
                [delegate loadImageDidFisish:self FinishImage:image];
            }
            
            [downloadDelegates removeObject:delegate];
            [downloadFileData removeObjectAtIndex:uidx];
            [downloaders removeObjectAtIndex:uidx];
        }
        
    }
    
}

-(void)fileDownloader:(CLFileDownload *)download didReceiver:(long)receiverLength contentLength:(long)length{

    for (NSInteger idx = (NSInteger)[downloaders count] - 1; idx >= 0; idx--)
    {
        NSUInteger uidx = (NSUInteger)idx;
        CLFileDownload *aDownloader = [downloaders objectAtIndex:uidx];
        if (aDownloader == download)
        {
            id<CLImageManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            if([delegate respondsToSelector:@selector(loadingImage:ReceiverData:ContentLength:)]){
                [delegate loadingImage:self ReceiverData:receiverLength ContentLength:length];
            }
        }
    }

}




#pragma mark FileCache Delegate

-(void)CLFileCache:(CLFileCache *)cache ImageDidFound:(UIImage *)image downloadInfo:(NSDictionary *)info{
    id<CLImageManagerDelegate> delegate = [info objectForKey:@"delegate"];
    if([delegate respondsToSelector:@selector(loadImageDidFisish:FinishImage:)]){
        [delegate loadImageDidFisish:self FinishImage:image];
    }
}

-(void)CLFileCache:(CLFileCache *)cache ImageDidNotFound:(FileData *)data downloadInfo:(NSDictionary *)info{
    id<CLImageManagerDelegate> delegate = [info objectForKey:@"delegate"];
    
    // Share the same downloader for identical URLs so we don't download the same URL several times
    CLFileDownload *downloader = [downloadUrls objectForKey:data.Url];
    
    if (!downloader)
    {
        downloader = [[CLFileDownload alloc]initWithUrl:data.Url];
        downloader.delegate = self;
        [downloader Start];
        [downloadUrls setObject:downloader forKey:data.Url];
    }
    
    [downloadDelegates addObject:delegate];
    [downloaders addObject:downloader];
    [downloadFileData addObject:data];
}




@end
