//
//  PopoverSelectionManager.m
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PopoverSelectionManager.h"
#import "PopoverTableViewController.h"

// Assumption: a valid option will never be "Other..."
static NSString *OTHER_OPTION_TEXT = @"Other...";
static NSString *NO_OPTIONS_AVAILABLE_PLACEHOLDER = @"";

@implementation PopoverSelectionManager

- (void)dealloc
{
    [_openPopoverButton release];
    [_options release];
    [_popover release];
    [_targetTextField release];
    
    [super dealloc];
}

// Designated initializer.
- (id)initWithButton:(UIButton *)openButton 
     targetTextField:(UITextField *)textField 
             options:(NSArray *)options 
  includeOtherOption:(BOOL)includeOther
{
    self = [super init];
    if (self)
    {
        [self setOptions:options includeOtherOption:includeOther];
        
        _openPopoverButton = [openButton retain];
        _targetTextField = [textField retain];
        
        [_openPopoverButton addTarget:self 
                               action:@selector(openPopover:) 
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithButton:(UIButton *)openButton 
     targetTextField:(UITextField *)textField
{
    return [self initWithButton:openButton 
                targetTextField:textField 
                        options:nil 
             includeOtherOption:NO];
}

- (void)setOptions:(NSArray *)options includeOtherOption:(BOOL)includeOther
{
    [_popover release];
    _popover = nil;
    
    [_options release];
    _options = nil;
    
    if (options)
    {
        _options = [NSMutableArray arrayWithArray:options];
        
        if (includeOther)
        {
            [_options addObject:OTHER_OPTION_TEXT];
        }
    }
    else
    {
        _options = [NSMutableArray arrayWithObject:NO_OPTIONS_AVAILABLE_PLACEHOLDER];
    }
    
    [_options retain];
}

- (UIPopoverController *)createOrReusePopover
{
    if (!_popover)
    {
        PopoverTableViewController *tvc = [[[PopoverTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        tvc.dataItems = _options;
        tvc.delegate = self;
        tvc.contentSizeForViewInPopover = tvc.naturalSize;
        _popover = [[UIPopoverController alloc] initWithContentViewController:tvc];
    }
    return _popover;
}

- (void)openPopover:(id) sender
{
    UIPopoverController *popover = [self createOrReusePopover];
    if (popover.popoverVisible)
    {
        [popover dismissPopoverAnimated:YES];
    }
    else
    {
        CGSize sz = _openPopoverButton.frame.size;
        
        [popover presentPopoverFromRect:CGRectMake(0, 0, sz.width, sz.height) 
                                 inView:_openPopoverButton 
               permittedArrowDirections:UIPopoverArrowDirectionAny 
                               animated:YES];
    }
}

#pragma mark - PopoverTableViewControllerDelegate members

- (void)popoverTableViewController:(PopoverTableViewController *)popoverTableViewController 
                   didSelectOption:(NSString *)selectedOption
{
    BOOL hasOptions = 
    _options
    && [_options count] 
    && ![[_options objectAtIndex:0] isEqualToString:NO_OPTIONS_AVAILABLE_PLACEHOLDER];
    
    if (hasOptions)
    {
        // The text field must have focus for UITextFieldTextDidChangeNotification to be broadcast.
        [_targetTextField becomeFirstResponder];
        
        // Inject the selected text into the text field, or nil if the user selected the Other option.
        BOOL isOtherOption = [selectedOption isEqualToString:OTHER_OPTION_TEXT];
        _targetTextField.text = isOtherOption ? nil : selectedOption;
    }

    // Hide the popover list.
    [_popover dismissPopoverAnimated:YES];
}

@end
