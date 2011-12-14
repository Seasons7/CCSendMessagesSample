//
//  AppDelegate.h
//  CCSendMessagesSamples
//
//  Created by 畑 圭輔 on 11/12/14.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
