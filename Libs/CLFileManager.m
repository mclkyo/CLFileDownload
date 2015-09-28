//
//  CLFileManager.m
//  SocketClient
//
//  Created by yilecity on 15/9/18.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "CLFileManager.h"
#import "CLFileCache.h"

static CLFileManager *instance;

@implementation CLFileManager


+(id)shareFileManager{
    
    if(instance == nil){
        instance = [[CLFileManager alloc]init];
    }
    return instance;
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


-(void)DownloadFile:(id<CLFileManagerDelegate>)delegate FileUrl:(NSString *)Url{
    [self cancelForDelegate:delegate];
    [self downloadWithUrl:Url ManagerDelegate:delegate];
}


- (NSUInteger)indexOfDelegate:(id<CLFileManagerDelegate>)delegate
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


-(void)downloadWithUrl:(NSString *)url ManagerDelegate:(id<CLFileManagerDelegate>)delegate{
    
    FileData *data = [[FileData alloc]initWithUrl:url];
    CLFileCache *cache = [CLFileCache sharedFileCache];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          delegate, @"delegate",
                          data , @"filedata",
                          nil];
    
    [cache queryDiskFileCache:data Result:self downloadInfo:info];
    
}


-(void)cancelForDelegate:(id<CLFileManagerDelegate>)delegate{
    
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
            id<CLFileManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            
            if([delegate respondsToSelector:@selector(loadFileFail:Error:)]){
                [delegate loadFileFail:self Error:error];
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
            id<CLFileManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            FileData *filedata = [downloadFileData objectAtIndex:uidx];
            filedata.Data = data;
            
            //[[CLFileCache sharedFileCache]storeFile:filedata DownloadFile:data];
            [[CLFileCache sharedFileCache]storeFile:filedata DownloadFile:data Callback:^{
                
                if([delegate respondsToSelector:@selector(loadFileDidFisish:FinishFile:)]){
                    [delegate loadFileDidFisish:self FinishFile:data];
                }
                
                if([delegate respondsToSelector:@selector(loadFileDidFisish:FinishFileUrl:)]){
                    NSString *FileUrl = [[CLFileCache sharedFileCache] getSavePath:filedata.Key];
                    [delegate loadFileDidFisish:self FinishFileUrl:FileUrl];
                }
                
            }];
            
            
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
            id<CLFileManagerDelegate> delegate = [downloadDelegates objectAtIndex:uidx];
            if([delegate respondsToSelector:@selector(loadingFile:ReceiverData:ContentLength:)]){
                [delegate loadingFile:self ReceiverData:receiverLength ContentLength:length];
            }
        }
    }
    
}




#pragma mark FileCache Delegate

-(void)CLFileCache:(CLFileCache *)cache FileDidFound:(NSData *)data downloadInfo:(NSDictionary *)info{
    id<CLFileManagerDelegate> delegate = [info objectForKey:@"delegate"];
    if([delegate respondsToSelector:@selector(loadFileDidFisish:FinishFile:)]){
        [delegate loadFileDidFisish:self FinishFile:data];
    }
    
    if([delegate respondsToSelector:@selector(loadFileDidFisish:FinishFileUrl:)]){
        FileData *filedata = [info objectForKey:@"filedata"];
        NSString *FileUrl = [[CLFileCache sharedFileCache] getSavePath:filedata.Key];
        [delegate loadFileDidFisish:self FinishFileUrl:FileUrl];
    }
    
}

-(void)CLFileCache:(CLFileCache *)cache FileDidNotFound:(FileData *)data downloadInfo:(NSDictionary *)info{
    id<CLFileManagerDelegate> delegate = [info objectForKey:@"delegate"];
    
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
