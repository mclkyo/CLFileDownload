//
//  WavPlayViewController.h
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLFileManager.h"

@interface WavPlayViewController : UIViewController<CLFileManagerDelegate>


-(IBAction)Play:(id)sender;

@end
