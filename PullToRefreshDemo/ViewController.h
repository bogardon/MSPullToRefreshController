//
//  ViewController.h
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPullToRefresh.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomPullToRefreshDelegate> {
    UITableView *_table;
    NSMutableArray *_primes;
    CustomPullToRefresh *_ptf;
}

- (BOOL) isPrime:(unsigned long long)input;
- (void) findNextPrime;
- (void) endSearch;

@property (nonatomic, retain) IBOutlet UITableView *table;


@end
