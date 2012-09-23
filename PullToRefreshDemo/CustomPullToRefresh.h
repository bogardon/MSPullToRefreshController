//
//  CustomPullToRefresh.h
//  PullToRefreshDemo
//
//  Created by John Wu on 3/22/12.
//  Copyright (c) 2012 TFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"

@protocol CustomPullToRefreshDelegate;

@interface CustomPullToRefresh : NSObject <MSPullToRefreshDelegate> {
    UIImageView *_rainbowTop;
    UIImageView *_arrowTop;
    UIImageView *_rainbowBot;
    UIImageView *_arrowBot;
    MSPullToRefreshController *_ptrc;
    UIScrollView *_scrollView;
    
    id <CustomPullToRefreshDelegate> _delegate;
}

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id <CustomPullToRefreshDelegate>)delegate;
- (void) endRefresh;
- (void) startRefresh;

@end

@protocol CustomPullToRefreshDelegate <NSObject>

- (void) customPullToRefreshShouldRefresh:(CustomPullToRefresh *)ptr;

@end