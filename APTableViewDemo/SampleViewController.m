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
    [self checkAccounts];
    
    self.apViewController = [[APTableViewController alloc]initWithStyle:UITableViewStylePlain];
    self.apViewController.view.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:self.apViewController.view];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkAccounts {
    __block __weak SampleViewController *weakSelf = self;
    ACAccountType *accountType;
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore
         requestAccessToAccountsWithType:accountType
         options:nil
         completion:^(BOOL granted, NSError *error) {
             NSArray *accountArray = [accountStore accountsWithAccountType:accountType];
             for (ACAccount *account in accountArray) {
                 NSString *text = [NSString stringWithFormat:@"@%@", [account username]];
                 [weakSelf performSelectorOnMainThread:@selector(showTwitterAccount:)
                                            withObject:text
                                         waitUntilDone:YES];
             }
         }];
    }
}

@end
