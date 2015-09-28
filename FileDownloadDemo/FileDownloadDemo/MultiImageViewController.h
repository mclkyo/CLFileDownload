//
//  MultiImageViewController.h
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiImageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@end

@interface MultiImageCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView *ToDownloadImage;
-(void)SetDownloadUrl:(NSString*)Url;
@end

