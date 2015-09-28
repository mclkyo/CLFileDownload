//
//  WavPlayViewController.m
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "WavPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WavPlayViewController (){
    AVAudioPlayer *player;
}

@end

@implementation WavPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Play:(id)sender{
    
    [[CLFileManager shareFileManager] DownloadFile:self FileUrl:@"http://www.jiu3000.com/sifi.wav"];
    
    
}

#pragma mark FileDownload delegate

-(void)loadFileDidFisish:(CLFileManager *)manager FinishFile:(NSData *)data{
    NSLog(@"%@",@"finish");
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    [player play];
}

-(void)loadFileFail:(CLFileManager *)manager Error:(NSError *)error{
    NSLog(@"%@",error);
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
