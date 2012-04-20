# [GoMiso's](http://gomiso.com) Pull To Refresh Library

#### Authors
Me and [Tim Lee](https://github.com/timothy1ee)

#### Pull To Refresh Demo
I've put together a simple sample project that recreates our familiar rainbow loading in the [Miso App](http://itunes.apple.com/us/app/miso-social-tv/id352823603?mt=8).
The sample artificially creates async work by finding the next largest prime and putting the results into a regular uitableview.

#### Features
* does not steal your scrollview's delegate (intrusive), but merely observes the scrollview's contentOffset property (non-intrusive)
* allows refreshing in all 4 directions (pull down to refresh, pull up to load more?)

#### How To Use
Note that this library merely abstracts away the refresh cycle logic. It is up to the developer to use this class combined with custom views to create a complete, visually satisfactory solution.

There's only one constructor:

	MSPullToRefreshController *ptrc = [[MSPullToRefreshController alloc] initWithScrollView:scrollView delegate:self];

As the Delegate, you must implement these methods to inform the library of your specific refresh requirements:
	
	/*
	 * asks the delegate which refresh directions it would like enabled
	 */
	- (BOOL) pullToRefreshController:(MSPullToRefreshController *) controller canRefreshInDirection:(MSRefreshDirection)direction;

	/*
	 * inset threshold to engage refresh
	 */
	- (CGFloat) pullToRefreshController:(MSPullToRefreshController *) controller refreshableInsetForDirection:(MSRefreshDirection) direction;

	/*
	 * inset that the direction retracts back to after refresh started
	 */
	- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction;

You may (it is in your best interest to) to implement these methods in order to transform your custom views based on where you are in the refresh cycle:

	/*
	 * informs the delegate that lifting your finger will trigger a refresh
	 * in that direction. This is only called when you cross the refreshable
	 * offset defined in the respective MSInflectionOffsets.
	 */
	- (void) pullToRefreshController:(MSPullToRefreshController *) controller canEngageRefreshDirection:(MSRefreshDirection) direction;

	/*
	 * informs the delegate that lifting your finger will NOT trigger a refresh
	 * in that direction. This is only called when you cross the refreshable
	 * offset defined in the respective MSInflectionOffsets.
	 */
	- (void) pullToRefreshController:(MSPullToRefreshController *) controller didDisengageRefreshDirection:(MSRefreshDirection) direction;

	/*
	 * informs the delegate that refresh sequence has been started by the user
	 * in the specified direction. A good place to start any async work.
	 */
	- (void) pullToRefreshController:(MSPullToRefreshController *) controller didEngageRefreshDirection:(MSRefreshDirection) direction;

Note that you must manually end a refresh cycle in any direction:

	[ptrc finishRefreshingDirection:MSRefreshDirectionTop animated:NO];

You can also programatically start a refresh cycle in any direction:

	[ptrc startRefreshingDirection:MSRefreshDirectionTop animated:YES];

#### Caution

This library will break down if the area of the scrollView's contentSize is smaller (strict) than the area of the scrollView's frame. It is up to the developer to ensure the converse.

#### License

MSPullToRefreshController is available under the MIT license. See the LICENSE file for more info.