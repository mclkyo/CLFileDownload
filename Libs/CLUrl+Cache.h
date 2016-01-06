//
//  CLUrl+Cache.h
//  FileDownloadDemo
//
//  Created by yilecity on 1/6/16.
//  Copyright © 2016 yilecity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLImageManager.h"
#import "CLImageManagerDelegate.h"

typedef void (^LoadImageSuccess)(UIImage *image);

@interface NSString (Cache)<CLImageManagerDelegate>{
    
}

-(void)LoadImage:(LoadImageSuccess)block;

@end
