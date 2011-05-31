//
//  DataEntryViewController.m
//  PopoverDemo
//
//  Created by Josh Smith on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataEntryViewController.h"
#import "PopoverSelectionManager.h"

@implementation DataEntryViewController
@synthesize cityTextField;
@synthesize cityPopoverButton;
@synthesize cityPopoverSelectionManager;
@synthesize stateTextField;
@synthesize statePopoverButton;
@synthesize statePopoverSelectionManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        NSArray *azCities = [NSArray arrayWithObjects:@"Phoenix", @"Scottsdale", @"Tuscon", nil];
        NSArray *ctCities = [NSArray arrayWithObjects:@"Bridgeport", @"Fairfield", @"Hartford", @"New Haven", nil];
        NSArray *waCities = [NSArray arrayWithObjects:@"Bellevue", @"Redmond", @"Seattle", nil];
        statesToCities = [NSDictionary dictionaryWithObjectsAndKeys:
                          azCities, @"AZ", 
                          ctCities, @"CT", 
                          waCities, @"WA", 
                          nil];
        [statesToCities retain];
    }
    return self;
}

- (void)dealloc
{
    [cityTextField release];
    [cityPopoverButton release];
    [cityPopoverSelectionManager release];
    [stateTextField release];
    [statePopoverButton release];
    [statePopoverSelectionManager release];
    [statesToCities release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.statePopoverSelectionManager = [[PopoverSelectionManager alloc] initWithButton:self.statePopoverButton 
                                                                        targetTextField:self.stateTextField 
                                                                                options:[statesToCities allKeys] 
                                                                     includeOtherOption:YES];
    
    // The 'options' list will be provided once the State has been selected.
    self.cityPopoverSelectionManager = [[PopoverSelectionManager alloc] initWithButton:self.cityPopoverButton 
                                                                        targetTextField:self.cityTextField];
    
    // Listen for changes to the State text field so that we can update the list of cities.
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(stateTextChanged:) 
                                                 name:UITextFieldTextDidChangeNotification 
                                               object:self.stateTextField];
}

- (void)viewDidUnload
{
    [self setCityTextField:nil];
    [self setCityPopoverButton:nil];
    [self setCityPopoverSelectionManager:nil];
    [self setStateTextField:nil];
    [self setStatePopoverButton:nil];
    [self setStatePopoverSelectionManager:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)stateTextChanged:(NSNotification *)note
{
    // When the state name changes, the city name becomes garbage.
    self.cityTextField.text = nil;
    
    // Update the list of cities for the new state, or nil if the state name is invalid.
    NSString *stateName = [self.stateTextField.text uppercaseString];
    if (stateName)
    {
        NSArray *cities = [statesToCities objectForKey:stateName];
        [self.cityPopoverSelectionManager setOptions:cities includeOtherOption:YES];
    }
}

@end
