//
//  PopoverDemoAppDelegate.h
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataEntryViewController;

@interface PopoverDemoAppDelegate : NSObject <UIApplicationDelegate> {
    DataEntryViewController *dataEntryVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
