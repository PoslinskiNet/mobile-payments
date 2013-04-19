//
//  DemoZooZSDKAppDelegate.h
//  DemoZooZSDK
//
//  Created by Ronen Morecki on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoZooZSDKViewController;

@interface DemoZooZSDKAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DemoZooZSDKViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DemoZooZSDKViewController *viewController;

@end

