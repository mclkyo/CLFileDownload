//
//  CLFileManager.h
//  SocketClient
//
//  Created by yilecity on 15/9/18.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLFileDownload.h"
#import "CLFileCache.h"
#import "CLFileManagerDelegate.h"
#import "FileData.h"

@interface CLFileManager : NSObject<CLFileDownloadDelegate,CLFileCacheDelegate>{
    NSMutableArray *downloadDelegates;
    NSMutableDictionary *downloadUrls;
    NSMutableArray *downloaders;
    NSMutableArray *downloadFileData;
    NSMutableArray *cacheDelegates;
    NSMutableArray *cacheURLs;
    
}

+(id)shareFileManager;

-(void)downloadWithUrl:(NSString*)url ManagerDelegate:(id<CLFileManagerDelegate>) delegate;
-(void)cancelForDelegate:(id<CLFileManagerDelegate>)delegate;


-(void)DownloadFile:(id<CLFileManagerDelegate>)delegate FileUrl:(NSString*)Url;

@end
