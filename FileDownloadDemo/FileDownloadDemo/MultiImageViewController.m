//
//  MultiImageViewController.m
//  FileDownloadDemo
//
//  Created by yilecity on 15/9/28.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "MultiImageViewController.h"
#import "CLUIImageView+Cache.h"
#import "CLUrl+Cache.h"

@interface MultiImageViewController (){
    NSMutableArray *DataSource;
    NSMutableArray *lstMemory;
}

@end

@implementation MultiImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lstMemory = [NSMutableArray array];
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
    
    
    NSMutableArray *lstImageUrl = [[NSMutableArray alloc]init];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202247.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202249.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202251.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202253.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223K8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223P0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223P4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223P8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Q0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Q1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Q3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Q6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Q7.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223R1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223R4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223R6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223R8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223S1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223S9.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223T1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223T5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223U4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223U9.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223Z4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223916.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223920.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223924.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223927.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223933.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223939.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223946.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223951.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111223956.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111224000.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111224006.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111224010.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111224013.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222I4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222I6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222J1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222J3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222J6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222J8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222K0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222K3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222K5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222K7.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222K9.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222P1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222P3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222P5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222P7.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222P9.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q7.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222Q8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222R4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160111/1-160111222R8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95639.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95649.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95A0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95A1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95A1-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151118/1-15111P95A2.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202148.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202149.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202154-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202155.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202155-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202156.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202157.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202158.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202159.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202200.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202201.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202201-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202203-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202204.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202205.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202205-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202207.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202215.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202218.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202220.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202222.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202224.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202226.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202228.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202231.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202233.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202235.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202237.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202239.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202241.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202243.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151109/1-151109202245.jpg"];
    
    
    
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S356.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S358.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S402.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S405.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S407.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S409.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S417-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S411.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S413.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S415.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S416.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S417.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S430.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S420.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S422.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S424.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S426.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S428.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S442.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S432.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S434.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S436.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S438.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/160112/1-1601121S440.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A6-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A7.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A8.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F0.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122A8-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F1.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F1-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F2.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F3.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F4.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F5.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151229/1-151229122F6.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111319.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111320.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111323.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111325.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111321-50.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111321-51.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111327.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111329.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111321.jpg"];
    [lstImageUrl addObject:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111337.jpg"];
    
    
    
    
    
    NSLog(@"%u",lstImageUrl.count);
    
    [lstImageUrl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *url = (NSString*)obj;
        
        [url LoadImage:^(UIImage *image) {
            NSLog(@"%u %f %f", idx ,image.size.width,image.size.height);
        }];
    }];

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        while (true) {
            for(int i=0;i<10000;i++){
                [lstMemory addObject:[NSString stringWithFormat:@"http://mm.xmeise.com/uploads/allimg/151221/1-151221111337.jpg%d",i]];
            }
            NSLog(@"%u",lstMemory.count);
            sleep(1);
        }
    });
    
    
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.mCell==nil){
        self.mCell = [tableView dequeueReusableCellWithIdentifier:@"MultiImage"];
    }
    
    NSString *index = [DataSource objectAtIndex:indexPath.row];
    [self.mCell SetDownloadUrl:index];

    CGSize size =  [self.mCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return 1  + size.height;
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
