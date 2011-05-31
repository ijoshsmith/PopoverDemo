//
//  DataEntryViewController.h
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopoverSelectionManager;

@interface DataEntryViewController : UIViewController {
    
    UITextField *cityTextField;
    UIButton *cityPopoverButton;
    UITextField *stateTextField;
    UIButton *statePopoverButton;

    PopoverSelectionManager *cityPopoverSelectionManager;
    PopoverSelectionManager *statePopoverSelectionManager;
    
    NSDictionary *statesToCities;
}
@property (nonatomic, retain) IBOutlet UITextField *cityTextField;
@property (nonatomic, retain) IBOutlet UIButton *cityPopoverButton;
@property (nonatomic, retain) IBOutlet UITextField *stateTextField;
@property (nonatomic, retain) IBOutlet UIButton *statePopoverButton;

@property (nonatomic, retain) PopoverSelectionManager *statePopoverSelectionManager;
@property (nonatomic, retain) PopoverSelectionManager *cityPopoverSelectionManager;

@end
