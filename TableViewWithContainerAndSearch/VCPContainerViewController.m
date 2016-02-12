//
//  VCPContainerViewController.m
//  VCPMobile
//
//  Created by SBouchard on 2016-02-02.
//  Copyright © 2016 IDEXX Laboratories, Inc. All rights reserved.
//
#import "VCPContainerViewController.h"



#define SegueIdentifierCompleteList @"completeListEmbed"
#define SegueIdentifierInProcessList @"inProcessListEmbed"

@interface VCPContainerViewController ()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) UITableViewController *completedTestList;
@property (strong, nonatomic) UITableViewController *inProcessTestList;
@property (assign, nonatomic) BOOL transitionInProgress;


@end

@implementation VCPContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SegueIdentifierCompleteList;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SegueIdentifierCompleteList]) {
        self.completedTestList = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierInProcessList]) {
        self.inProcessTestList = segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierCompleteList]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.completedTestList];
        }
        else {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    // By definition the second view controller will always be swapped with the first one.
    else if ([segue.identifier isEqualToString:SegueIdentifierInProcessList]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.inProcessTestList];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

- (void)swapViewControllers
{
    if (self.transitionInProgress) {
        return;
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SegueIdentifierCompleteList]) ? SegueIdentifierInProcessList : SegueIdentifierCompleteList;
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierCompleteList]) && self.completedTestList) {
        [self swapFromViewController:self.inProcessTestList toViewController:self.completedTestList];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierInProcessList]) && self.inProcessTestList) {
        [self swapFromViewController:self.completedTestList toViewController:self.inProcessTestList];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}


@end
