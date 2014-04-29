//
//  ViewController.h
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)actionCurrentLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;

- (IBAction)actionDone:(id)sender;

@end
