
//
//  ComplteListTableViewController.m
//  TableViewWithContainerAndSearch
//
//  Created by SBouchard on 2016-02-12.
//  Copyright © 2016 Solutions Waizu inc. All rights reserved.
//

#import "ComplteListTableViewController.h"

@interface ComplteListTableViewController () <UIScrollViewDelegate>

@end

@implementation ComplteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.bounces = NO;
    
    [self.tableView setDelaysContentTouches:YES];
   [self.tableView setCanCancelContentTouches:NO];
    
  //  self.tableView.panGestureRecognizer.delaysTouchesBegan = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController* resultCtrl = [sb instantiateViewControllerWithIdentifier:@"detailCtrl"];
    
    
    if(self.navigationController){
        [self.navigationController pushViewController:resultCtrl animated:YES];
    }
    else{
        [self.navController pushViewController:resultCtrl animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog([NSString stringWithFormat:@"Offset: %f", scrollView.contentOffset.y ]);
//    if(scrollView.contentOffset.y <=0){
//        CGPoint offset = self.otterTV.contentOffset ; // both tables have same offset so use anyone for reference
//        offset.y = offset.y-scrollView.contentOffset.y ;
//        self.otterTV.contentOffset = offset;
//    }
    
//
//        NSNumber *offset = [NSNumber numberWithFloat:scrollView.contentOffset.y];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollMan" object:nil userInfo:@{@"offset":offset}];

//    if(scrollView.contentOffset.y > 0){
//        self.tableView.scrollEnabled = YES;
//    }else{
//        self.tableView.scrollEnabled = NO;
//    }
    
//    self.resultCtrl.tableView.scrollEnabled=YES;
}

@end