//
//  CLFileManagerDelegate.h
//  SocketClient
//
//  Created by yilecity on 15/9/18.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//


@class CLFileManager;

@protocol CLFileManagerDelegate <NSObject>

@optional


-(void)loadFileDidFisish:(CLFileManager*)manager FinishFile:(NSData*)data;
-(void)loadFileDidFisish:(CLFileManager*)manager FinishFileUrl:(NSString*)FileUrl;

-(void)loadFileFail:(CLFileManager*)manager Error:(NSError*)error;
-(void)loadingFile:(CLFileManager *)manager ReceiverData:(long)recieverData ContentLength:(long)contentlength;

@end