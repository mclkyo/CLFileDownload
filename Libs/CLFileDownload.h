//
//  CLFileDownload.h
//  size class
//
//  Created by yilecity on 15/7/27.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLFileDownloadDelegate.h"

@interface CLFileDownload : NSObject{
    NSMutableData *receiverData;
    NSString *url;
    NSURLConnection *connection;
    NSMutableURLRequest *request;
    long ContentLength;
    long ReceiverLength;
}

@property(nonatomic,assign)id<CLFileDownloadDelegate> delegate;
@property(nonatomic,assign)double DownloadTimeOut;
@property(nonatomic,strong)NSString *Url;

-(id)initWithUrl:(NSString*)Url;
-(void)Start;
-(void)Cancel;
@end
