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
static char SuccessBlockKey;

@implementation UIImageView(Cache)



-(void)setUrl:(NSString *)url{
    if(url==nil || url.length == 0)
        return;
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    self.image = nil;
    [manager downloadWithUrl:url ManagerDelegate:self];
}


-(void)setUrl:(NSString *)url placeHolderImage:(UIImage *)placeImage{
    self.image = placeImage;
    
    if(url==nil || url.length == 0)
        return;
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    [manager downloadWithUrl:url ManagerDelegate:self];
}



-(void)setUrl:(NSString *)url SuccessBlock:(LoadSuccess)block{
    self.image = nil;
    if(url==nil || url.length == 0)
        return;
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    objc_setAssociatedObject(self, &SuccessBlockKey, block, OBJC_ASSOCIATION_COPY);
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    [manager downloadWithUrl:url ManagerDelegate:self];
    

    
}


-(void)setUrl:(NSString *)url LoadingBlock:(LoadingImageBlock)block{
    self.image = nil;
    if(url==nil || url.length == 0)
        return;
    
    CLImageManager *manager = [CLImageManager shareImageManager];
    objc_setAssociatedObject(self, &LoadingBlockKey, block, OBJC_ASSOCIATION_COPY);
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    [manager downloadWithUrl:url ManagerDelegate:self];
    

}




#pragma mark CLImageManager Delegate

-(void)loadImageDidFisish:(CLImageManager *)manager FinishImage:(UIImage *)image{
    self.image = image;
    LoadSuccess block = objc_getAssociatedObject(self, &SuccessBlockKey);
    if(block!=nil){
        block();
    }

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