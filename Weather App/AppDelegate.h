//
//  AppDelegate.h
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *myLocationManager;

@end
