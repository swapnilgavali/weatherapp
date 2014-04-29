//
//  WeatherCelll.h
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface WeatherCelll : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblDay;
@property (strong, nonatomic) IBOutlet UILabel *lblMin;
@property (strong, nonatomic) IBOutlet UILabel *lblMax;
@property (strong, nonatomic) IBOutlet UILabel *lblNight;
@property (strong, nonatomic) IBOutlet UILabel *lblEve;
@property (strong, nonatomic) IBOutlet UILabel *lblMain;
@property (strong, nonatomic) IBOutlet UILabel *lblDesc;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgViewWe;
@property (strong, nonatomic) IBOutlet UILabel *lblMorn;

@end
