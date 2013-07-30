//
//  SampleViewController.m
//  APTableViewDemo
//
//  Created by SOMTD on 2013/07/29.
//  Copyright (c) 2013年 SOMTD. All rights reserved.
//

#import "SampleViewController.h"
#import "APTableViewController.h"

@interface SampleViewController ()
@property (nonatomic, strong) APTableViewController *apViewController;

@end

@implementation SampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.apViewController = [[APTableViewController alloc]initWithStyle:UITableViewStylePlain];
    self.apViewController.view.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:self.apViewController.view];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
