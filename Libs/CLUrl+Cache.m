//
//  CLUrl+Cache.m
//  FileDownloadDemo
//
//  Created by yilecity on 1/6/16.
//  Copyright © 2016 yilecity. All rights reserved.
//

#import "CLUrl+Cache.h"
#import <objc/runtime.h>

static char LoadImageSuccessBlockKey;

@implementation NSString (Cache)


-(void)LoadImage:(LoadImageSuccess)block{
        
    if(self==nil || self.length == 0)
        return;

    
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    objc_setAssociatedObject(self, &LoadImageSuccessBlockKey, block, OBJC_ASSOCIATION_COPY);
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    [manager downloadWithUrl:self ManagerDelegate:self];
}


#pragma mark CLImageManager Delegate

-(void)loadImageDidFisish:(CLImageManager *)manager FinishImage:(UIImage *)image{
 
    LoadImageSuccess block = objc_getAssociatedObject(self, &LoadImageSuccessBlockKey);
    if(block!=nil){
        block(image);
    }
    
}
 

@end
