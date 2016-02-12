
//
//  ComplteListTableViewController.m
//  TableViewWithContainerAndSearch
//
//  Created by SBouchard on 2016-02-12.
//  Copyright © 2016 Solutions Waizu inc. All rights reserved.
//

#import "ComplteListTableViewController.h"

@interface ComplteListTableViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ComplteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //register to listen for event
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"scroll"
     object:nil ];
    

}

//event handler when event occurs
-(void)eventHandler: (NSNotification *) notification
{
    self.tableView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panOccured:(UIPanGestureRecognizer *)sender
{
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.tableView.contentOffset.y < 0){
        
        self.tableView.scrollEnabled = NO;
        
    }
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end