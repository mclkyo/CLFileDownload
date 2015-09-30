//
//  CLImageManager.h
//  size class
//
//  Created by yilecity on 15/7/28.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLFileDownload.h"
#import "CLFileCache.h"
#import "CLImageManagerDelegate.h"
#import "FileData.h"

@interface CLImageManager : NSObject<CLFileDownloadDelegate,CLFileCacheDelegate>{
    
    NSMutableArray *downloadDelegates;
    NSMutableDictionary *downloadUrls;
    NSMutableArray *downloaders;
    NSMutableArray *downloadFileData;
    
    NSMutableArray *cacheDelegates;
    NSMutableArray *cacheURLs;
}



+(id)shareImageManager;

-(void)downloadWithUrl:(NSString*)url ManagerDelegate:(id<CLImageManagerDelegate>) delegate;
-(void)cancelForDelegate:(id<CLImageManagerDelegate>)delegate;

-(void)DownloadUIImage:(id<CLImageManagerDelegate>) obj ImageUrl:(NSString*)Url;

@end

