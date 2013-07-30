//
//  APTableViewController.m
//  APTableViewDemo
//
//  Created by SOMTD on 2013/07/29.
//  Copyright (c) 2013年 SOMTD. All rights reserved.
//

#import "APTableViewController.h"
#import "AFNetworking.h"
#import "Beer.h"

const int kLoadingCellTag = 1273;

@interface APTableViewController () {
    NSInteger _currentPage;
    NSInteger _totalPages;
}
@property (nonatomic, strong) NSMutableArray *beers;
- (void)fetchBeers;

@end

@implementation APTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.beers = [NSMutableArray array];
    _currentPage = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasources methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_currentPage == 0) {
        return 1;
    }
    
    if (_currentPage < _totalPages) {
        return self.beers.count + 1;
    }
    return self.beers.count;
}

- (UITableViewCell *)beerCellForIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [self.tableView
                             dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellIdentifier];
    }
    
    Beer *beer = [self.beers objectAtIndex:indexPath.row];
    cell.textLabel.text = beer.name;
    cell.detailTextLabel.text = beer.brewery;
    
    return cell;
}

- (UITableViewCell *)loadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc]
                              initWithStyle:UITableViewCellStyleDefault
                              reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = cell.center;
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    cell.tag = kLoadingCellTag;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.beers.count) {
        return [self beerCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.tag == kLoadingCellTag) {
        _currentPage++;
        [self fetchBeers];
    }
}

#pragma mark fetching

//GET /v1/beers.json HTTP/1.1
//Host: api.openbeerdatabase.com
//Content-Type: application/json; charset=utf-8

//Public Token
//df67c6de4a2a0950693027befd1974c55d42a69c2c084b1f80558a843b06f3c2

- (void)fetchBeers {
    NSString *host = @"api.openbeerdatabase.com";
    NSString *token = @"df67c6de4a2a0950693027befd1974c55d42a69c2c084b1f80558a843b06f3c2";
    NSString *urlString = [NSString
                           stringWithFormat:@"http://%@/v1/beers.json?page=%d&token=%@",host,_currentPage,token];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation =
    [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"responseObject %@", responseObject);
         
         _totalPages = [[responseObject
                         objectForKey:@"pages"] intValue];
         
         for (id beerDictionary in [responseObject
                                    objectForKey:@"beers"]) {
             Beer *beer = [[Beer alloc]
                           initWithDictionary:beerDictionary];
             if (![self.beers containsObject:beer]) {
                 [self.beers addObject:beer];
             }
         }
         [self.tableView reloadData];
         
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", [error localizedDescription]);
         
     }];
    
    [operation start];
}

@end
