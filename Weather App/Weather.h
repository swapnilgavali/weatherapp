//
//  Weather.h
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (strong, nonatomic)  NSString *City;
@property (strong, nonatomic)  NSString *Date;
@property (strong, nonatomic)  NSString *Day;
@property (strong, nonatomic)  NSString *Min;
@property (strong, nonatomic)  NSString *Max;
@property (strong, nonatomic)  NSString *Night;
@property (strong, nonatomic)  NSString *Eve;
@property (strong, nonatomic)  NSString *Main;
@property (strong, nonatomic)  NSString *Desc;
@property (strong, nonatomic)  NSString *imgViewWe;
@property (strong, nonatomic)  NSString *Morn;
@end
