//
//  FileData.h
//  auto-layout
//
//  Created by mclkyo on 15/7/26.
//  Copyright (c) 2015年 mclkyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileData : NSObject

@property(nonatomic,strong)NSData *Data;
@property(nonatomic,strong)NSString *Url;
@property(nonatomic,strong)NSString *Key;

-(id)initWithUrl:(NSString*)url;

@end
