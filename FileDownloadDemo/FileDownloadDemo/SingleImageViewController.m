//
//  SingleImageViewController.m
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "SingleImageViewController.h"
#import "CLUIImageView+Cache.h"

@interface SingleImageViewController ()

@end

@implementation SingleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self.ToDownloadImage setUrl:@"http://mm.xmeise.com/uploads/allimg/150926/1-1509261I003.jpg" SuccessBlock:^{
//        //[self.ToDownloadImage updateConstraintsIfNeeded];
//        
//    }];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"CLFileCache"];
    NSString *picUrl = [diskCachePath stringByAppendingPathComponent:@"1.jpg"];
    
    [self.ToDownloadImage setUrl:picUrl SuccessBlock:^{
        //[self.ToDownloadImage updateConstraintsIfNeeded];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
