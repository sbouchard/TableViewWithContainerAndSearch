//
//  ComplteListTableViewController.h
//  TableViewWithContainerAndSearch
//
//  Created by SBouchard on 2016-02-12.
//  Copyright © 2016 Solutions Waizu inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplteListTableViewController : UITableViewController
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UITableView *otterTV;

-(void) canScroll:(BOOL)canScroll;
@end
