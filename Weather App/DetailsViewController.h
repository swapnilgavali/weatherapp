//
//  DetailsViewController.h
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray* DataArray;
@property (strong,nonatomic) CLLocation *locationData;
@property(nonatomic,strong)NSString *cityNames;
@property(nonatomic,strong)NSArray* City;
@end
