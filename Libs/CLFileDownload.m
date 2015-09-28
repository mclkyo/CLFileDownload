//
//  CLFileDownload.m
//  size class
//
//  Created by yilecity on 15/7/27.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import "CLFileDownload.h"

@implementation CLFileDownload


-(id)initWithUrl:(NSString *)Url{
    self = [super init];
    url = Url;
    self.Url = Url;
    return self;
}


-(void)Start{
    if(self.DownloadTimeOut==0){
        self.DownloadTimeOut = 5;
    }
    
    NSURL *RequestUrl = [NSURL URLWithString:url];
    request = [[NSMutableURLRequest alloc]initWithURL:RequestUrl];
    request.timeoutInterval = self.DownloadTimeOut;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];

    if(!connection){
        if([self.delegate respondsToSelector:@selector(fileDownloader:didFail:)]){
            [self.delegate fileDownloader:self didFail:nil];
        }
    }
    receiverData = [[NSMutableData alloc]init];
    
    [connection start];
}

-(void)Cancel{
    
    if (connection)
    {
        [connection cancel];
        connection = nil;
    }
}


#pragma mark connection delegate

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    if([((NSHTTPURLResponse *)response) statusCode]==200 || [((NSHTTPURLResponse *)response) statusCode]==302){
        ContentLength = response.expectedContentLength;
    }
    else{
        [aConnection cancel];
        connection = nil;
        receiverData = nil;
        
        if([self.delegate respondsToSelector:@selector(fileDownloader:didFail:)]){
            [self.delegate fileDownloader:self didFail:nil];
        }
    }
    
 
}


- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    ReceiverLength += data.length;
    [receiverData appendData:data];

    if([self.delegate respondsToSelector:@selector(fileDownloader:didReceiver:contentLength:)]){
        [self.delegate fileDownloader:self didReceiver:ReceiverLength contentLength:ContentLength];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    connection = nil;
    if([self.delegate respondsToSelector:@selector(fileDownloader:didFinish:)]){
        [self.delegate fileDownloader:self didFinish:[NSData dataWithData:receiverData]];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(fileDownloader:didFinish:)]){
        [self.delegate fileDownloader:self didFail:error];
    }
}




@end
