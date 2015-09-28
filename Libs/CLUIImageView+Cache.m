//
//  CLUIImageView+Cache.m
//  size class
//
//  Created by yilecity on 15/7/28.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import "CLUIImageView+Cache.h"
#import <objc/runtime.h>

static char LoadingBlockKey;

@implementation UIImageView(Cache)



-(void)setUrl:(NSString *)url{
    CLImageManager *manager = [CLImageManager shareImageManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];    
    [manager downloadWithUrl:url ManagerDelegate:self];
}


-(void)setUrl:(NSString *)url LoadingBlock:(LoadingImageBlock)block{
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    [manager downloadWithUrl:url ManagerDelegate:self];
    
    objc_setAssociatedObject(self, &LoadingBlockKey, block, OBJC_ASSOCIATION_COPY);
}




#pragma mark CLImageManager Delegate

-(void)loadImageDidFisish:(CLImageManager *)manager FinishImage:(UIImage *)image{
    self.image = image;
}

-(void)loadImageFail:(CLImageManager *)manager Error:(NSError *)error{
    
}

-(void)loadingImage:(CLImageManager *)manager ReceiverData:(long)recieverData ContentLength:(long)contentlength{
 
    LoadingImageBlock block = objc_getAssociatedObject(self, &LoadingBlockKey);
    if(block!=nil){
        block((CGFloat)recieverData / (CGFloat)contentlength);
    }
}



@end