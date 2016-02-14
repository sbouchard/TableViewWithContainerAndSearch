//
//  TableTableViewController.m
//  TableViewWithContainerAndSearch
//
//  Created by SBouchard on 2016-02-12.
//  Copyright © 2016 Solutions Waizu inc. All rights reserved.
//

#import "TableTableViewController.h"
#import "ComplteListTableViewController.h"
#import "VCPContainerViewController.h"

@interface TableTableViewController () <UIGestureRecognizerDelegate, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UIScrollViewDelegate >
@property (weak, nonatomic) IBOutlet VCPContainerViewController *ctrlContainer;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) ComplteListTableViewController* resultCtrl;

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.resultCtrl = [sb instantiateViewControllerWithIdentifier:@"completeCtrl"];
    self.resultCtrl.navController = self.navigationController;
    self.resultCtrl.otterTV = self.tableView;
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultCtrl];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;

    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    [self.searchController.searchBar sizeToFit];
    
//    UIPanGestureRecognizer*   swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
//    swipeGesture.delegate = self;
//    [self.tableView addGestureRecognizer:swipeGesture];

    // scroll just past the search bar initially
    CGPoint offset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
//    self.tableView.bounces = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(needToScroll:)
                                                 name:@"scrollMan"
                                               object:nil];


   }

- (void) needToScroll:(NSNotification *) notification{
    
    NSDictionary *data = [notification userInfo];
    NSNumber *offset = [data objectForKey:@"offset"];
    float y = [offset floatValue];
    
    CGPoint tvOffest = self.tableView.contentOffset;
    
     NSLog([NSString stringWithFormat:@"Offset new: %f", tvOffest.y ]);

    
    // SearBar appear
    if(y < 0 && y >= -64){
        if(tvOffest.y <=0 && tvOffest.y > -64){
            tvOffest.y = MAX(tvOffest.y + y, -64);
            self.tableView.contentOffset = tvOffest;
            return;
        }
    }
    
    if( y > 0){
        if(tvOffest.y <-20 && tvOffest.y >= -64){
            tvOffest.y = MIN(tvOffest.y + y, -20);
            self.tableView.contentOffset = tvOffest;
            return;
        }
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"List one", @"List two", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(10, 10, self.tableView.frame.size.width-20, 44);
    [segmentedControl addTarget:self action:@selector(swapViewController:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;


    [sectionHeader addSubview:segmentedControl];
    
    return sectionHeader;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.ctrlContainer = segue.destinationViewController;
        
    }
}

- (IBAction)swapViewController:(id)sender {
    [self.ctrlContainer swapViewControllers];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 //   NSLog([NSString stringWithFormat:@"Up: %f ", scrollView.contentOffset.y]);
//
//    if(scrollView.contentOffset.y >= -20){
//        TableTableViewController* __weak weakSelf = self;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            weakSelf.resultCtrl.tableView.scrollEnabled=YES;
//        });
//    }
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}


- (BOOL) gestureRecognizer: (UIGestureRecognizer*)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer: (UIGestureRecognizer*)otherGestureRecognizer
{
    
    float var2 = self.tableView.contentOffset.y;
    if ([gestureRecognizer isKindOfClass: [UIPanGestureRecognizer class]])
    {
//
//
    }
    
//    if(self.tableView.contentOffset.y == -20){
//        NSLog(@"Ijjer Scroll OFF");
//        TableTableViewController* __weak weakSelf = self;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [weakSelf.resultCtrl canScroll:NO];
//        });
//    }else{
//         NSLog([NSString stringWithFormat:@"Up: %f ", var2]);
//         [self.resultCtrl.tableView setUserInteractionEnabled:YES];
//    }
//    
//
//
//
//        
//        
////        if ([((UIPanGestureRecognizer*)gestureRecognizer) velocityInView: self.tableView].y > 0){
////            //Up
////            NSLog([NSString stringWithFormat:@"Up: %f ", var2]);
////            if(self.tableView.contentOffset.y == 0){
////                return NO;
////            }
////            
////        }else{
////            //Down
////            NSLog([NSString stringWithFormat:@"Down: %f ", var2]);
////            return YES;
////        }
//        
//        
//    }
//    
//
    
//    NSLog(@"Outer Scroll delegate");
    return YES;
}




@end
