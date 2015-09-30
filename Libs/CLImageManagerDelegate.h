//
//  CLImageManagerDelegate.h
//  size class
//
//  Created by yilecity on 15/7/28.
//  Copyright (c) 2015年 ylc. All rights reserved.
//


@class CLImageManager;

@protocol CLImageManagerDelegate <NSObject>

@optional


-(void)loadImageDidFisish:(CLImageManager*)manager FinishImage:(UIImage*)image;
-(void)loadImageFail:(CLImageManager*)manager Error:(NSError*)error;
-(void)loadingImage:(CLImageManager *)manager ReceiverData:(long)recieverData ContentLength:(long)contentlength;

@end