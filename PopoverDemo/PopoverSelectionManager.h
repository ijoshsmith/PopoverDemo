//
//  PopoverSelectionManager.h
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopoverTableViewController.h"// imported for PopoverTableViewControllerDelegate

// Orchestrates displaying a list of selectable options in a Popover control,
// and injecting the selected text into a text field.
@interface PopoverSelectionManager : NSObject <PopoverTableViewControllerDelegate> {
    @private
    BOOL _includeOtherOption;
    UIButton *_openPopoverButton;
    NSMutableArray *_options;
    UIPopoverController *_popover;
    UITextField *_targetTextField;
}

- (id)initWithButton:(UIButton *)openButton
     targetTextField:(UITextField *)textField
             options:(NSArray *)options
  includeOtherOption:(BOOL)includeOther;

- (id)initWithButton:(UIButton *)openButton
      targetTextField:(UITextField *)textField;

- (void)setOptions:(NSArray *)options
includeOtherOption:(BOOL)includeOther;

@end