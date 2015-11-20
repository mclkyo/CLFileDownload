//
//  CLUIImageView+Cache.h
//  size class
//
//  Created by yilecity on 15/7/28.
//  Copyright (c) 2015年 ylc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLImageManager.h"
#import "CLImageManagerDelegate.h"

typedef void (^LoadingImageBlock)(CGFloat percent);
typedef void (^LoadSuccess)();

@interface UIImageView (Cache) <CLImageManagerDelegate>{
    
}

-(void)setUrl:(NSString*)url;
-(void)setUrl:(NSString *)url placeHolderImage:(UIImage*)placeImage;
-(void)setUrl:(NSString *)url LoadingBlock:(LoadingImageBlock)block;
-(void)setUrl:(NSString *)url SuccessBlock:(LoadSuccess)block;


@end
