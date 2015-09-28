//
//  MultiImageViewController.m
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "MultiImageViewController.h"
#import "CLUIImageView+Cache.h"

@interface MultiImageViewController (){
    NSMutableArray *DataSource;
}

@end

@implementation MultiImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DataSource = [NSMutableArray array];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30T7.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30T9.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30U1.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30U4.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30U8.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150927/1-15092H30Z4.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150925/1-150925203115.jpg"];
    
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150925/1-150925203150.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150925/1-150925203222.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150925/1-150925203227.jpg"];
    [DataSource addObject:@"http://mm.xmeise.com/uploads/allimg/150925/1-150925203109.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MultiImageCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"MultiImage"];
    NSString *index = [DataSource objectAtIndex:indexPath.row];
    [Cell SetDownloadUrl:index];
    return Cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataSource.count;
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


@implementation MultiImageCell

-(void)SetDownloadUrl:(NSString *)Url{
    
    [self.ToDownloadImage setUrl:Url];
}

@end
