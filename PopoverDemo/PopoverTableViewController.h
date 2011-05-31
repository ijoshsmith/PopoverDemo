//
//  PopoverTableViewController.h
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopoverTableViewController;

@protocol PopoverTableViewControllerDelegate <NSObject>

- (void)popoverTableViewController:(PopoverTableViewController *)popoverTableViewController
                   didSelectOption:(NSString *)selectedOption;

@end

@interface PopoverTableViewController : UITableViewController {
    
}

@property (nonatomic, retain) NSArray * dataItems;
@property (nonatomic, assign) id<PopoverTableViewControllerDelegate> delegate;

- (CGSize)naturalSize;

@end
