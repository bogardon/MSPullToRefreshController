//
//  ViewController.m
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import "ViewController.h"
#import "MSPullToRefreshController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize table = _table;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _primes = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithUnsignedLongLong:2], nil];
    
    _ptf = [[CustomPullToRefresh alloc] initWithScrollView:self.table delegate:self];
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL) isPrime:(unsigned long long)input {
    for (unsigned long long i = 2; i < input/2+1; i++) {
        if (input % i == 0)
            return NO;
    }
    return YES;
}

- (void) findNextPrime {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    unsigned long long lastPrime = [[_primes lastObject] unsignedLongLongValue];
    unsigned long long potentialPrime = lastPrime + 1;
    while ( [self isPrime:potentialPrime] == NO ) 
        potentialPrime++;
    
    [_primes addObject:[NSNumber numberWithUnsignedLongLong:potentialPrime]];
    
    [NSThread sleepForTimeInterval:1];
    [pool release];
    [self performSelectorOnMainThread:@selector(endSearch) withObject:nil waitUntilDone:NO];
}

- (void) endSearch {
    [_ptf endRefresh];
    [self.table reloadData];
}

#pragma mark - UITableView Delegate Methods

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _primes.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer] autorelease];
    }
    
    cell.textLabel.text = [[_primes objectAtIndex:indexPath.row] stringValue];
    
    return cell;
}

#pragma mark - CustomPullToRefresh Delegate Methods

- (void) customPullToRefreshShouldRefresh:(CustomPullToRefresh *)ptf {
    [self performSelectorInBackground:@selector(findNextPrime) withObject:nil];
}



@end
