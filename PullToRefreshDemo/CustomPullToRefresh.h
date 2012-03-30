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
    UIImageView *_rainbow;
    UIImageView *_arrow;
    MSPullToRefreshController *_ptrc;
    
    id <CustomPullToRefreshDelegate> _delegate;
}

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id <CustomPullToRefreshDelegate>)delegate;
- (void) endRefresh;
- (void) startRefresh;

@end

@protocol CustomPullToRefreshDelegate <NSObject>

- (void) customPullToRefreshShouldRefresh:(CustomPullToRefresh *)ptr;

@end