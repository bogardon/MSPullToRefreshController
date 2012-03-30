//
//  CustomPullToRefresh.m
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import "CustomPullToRefresh.h"

@implementation CustomPullToRefresh

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id<CustomPullToRefreshDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        _ptrc = [[MSPullToRefreshController alloc] initWithScrollView:scrollView delegate:self];
        
        _rainbow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading-1.png"]];
        _rainbow.frame = CGRectMake(0, -scrollView.frame.size.height, scrollView.frame.size.width, scrollView.frame.size.height);
        NSMutableArray *animationImages = [NSMutableArray arrayWithCapacity:19];
        for (int i=1; i<20; i++) 
            [animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading-%d.png",i]]];
        _rainbow.animationImages = animationImages;
        _rainbow.animationDuration = 2;
        [scrollView addSubview:_rainbow];

        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big_arrow.png"]];
        _arrow.frame = CGRectMake(floorf((_rainbow.frame.size.width-_arrow.frame.size.width)/2), _rainbow.frame.size.height - _arrow.frame.size.height - 10 , _arrow.frame.size.width, _arrow.frame.size.height);
        [_rainbow addSubview:_arrow];
        
    }
    return self;
}

- (void) dealloc {
    [_ptrc release];
    [_arrow release];
    [_rainbow release];
    [super dealloc];
}

- (void) endRefresh {
    [_ptrc finishRefreshingDirection:MSRefreshDirectionTop];
    [_rainbow stopAnimating];
    _arrow.hidden = NO;
    _arrow.transform = CGAffineTransformIdentity;
}

- (void) startRefresh {
    [_ptrc startRefreshingDirection:MSRefreshDirectionTop];
}

#pragma mark - MSPullToRefreshDelegate Methods

- (BOOL) pullToRefreshController:(MSPullToRefreshController *)controller canRefreshInDirection:(MSRefreshDirection)direction {
    return direction == MSRefreshDirectionTop;
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction {
    return 5;
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshableInsetForDirection:(MSRefreshDirection)direction {
    return 30;
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller canEngageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrow.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrow.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction {
    _arrow.hidden = YES;
    [_rainbow startAnimating];
    [_delegate customPullToRefreshShouldRefresh:self];
}

@end
