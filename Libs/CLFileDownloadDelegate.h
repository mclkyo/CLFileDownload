//
//  CLFileDownloadDelegate.h
//  size class
//
//  Created by yilecity on 15/7/27.
//  Copyright (c) 2015年 ylc. All rights reserved.
//


@class CLFileDownload;

@protocol CLFileDownloadDelegate <NSObject>

@optional

-(void)fileDownloader : (CLFileDownload*)download didFail :(NSError*)error;
-(void)fileDownloader : (CLFileDownload*)download didFinish: (NSData*)data;
-(void)fileDownloader : (CLFileDownload*)download didReceiver : (long) receiverLength  contentLength :(long)length;

@end