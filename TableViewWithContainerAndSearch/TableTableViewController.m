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

@interface TableTableViewController () <UIGestureRecognizerDelegate, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet VCPContainerViewController *ctrlContainer;

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComplteListTableViewController* resultCtrl = [sb instantiateViewControllerWithIdentifier:@"completeCtrl"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultCtrl];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;

    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
//    self.definesPresentationContext = YES;
    
    [self.searchController.searchBar sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    [sectionHeader setBackgroundColor:[UIColor purpleColor]];
    
    
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.y < 1){
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scroll"
         object:nil ];
        
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}

@end
