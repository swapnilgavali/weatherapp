
//
//  DetailsViewController.m
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import "DetailsViewController.h"
#import "WeatherCelll.h"
#include "Weather.h"
@interface DetailsViewController ()
{
    NSMutableData *_responseData;

}
@end

@implementation DetailsViewController
@synthesize locationData,DataArray,City;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //lat=35&lon=139
    // Do any additional setup after loading the view.
      self.DataArray=[[NSMutableArray alloc]init];
   // NSString * lat;
   // NSString *lon;
   // if (self.locationData==nil) {
        
       // NSURL *url = [NSURL URLWithString:urlString];
        
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount=1;
        for (NSURL *url in self.City) {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
            [self.view addSubview: activityIndicator];
            
            [activityIndicator startAnimating];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 if ([data length] > 0 && error == nil)
                 {
                     NSDictionary *mainDict=(NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                     NSDictionary *dictCity=[mainDict valueForKey:@"city"];
                     
                     NSArray *arr=[mainDict valueForKey:@"list"];
                     
                     for (NSDictionary *dict in arr) {
                         
                         Weather *w=[[Weather alloc]init];
                         
                         w.City=[dictCity valueForKey:@"name"];
                         
                         NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
                         [dtfrm setDateFormat:@"MM/dd/yyyy"];
                         
                        // NSLog(@"%@",[dict valueForKey:@"dt"]);
                        // NSLog(@"%@",[dictCity valueForKey:@"name"]);
                         
                         double unixTimeStamp =[[dict valueForKey:@"dt"] doubleValue];
                         NSTimeInterval _interval=unixTimeStamp;
                         NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                         NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
                         [_formatter setLocale:[NSLocale currentLocale]];
                         [_formatter setDateFormat:@"dd.MM.yyyy"];
                         NSString *_date=[_formatter stringFromDate:date];
                         w.Date = _date;
                         NSDictionary *temp =[dict valueForKey:@"temp"];
                         w.Day=[[temp valueForKey:@"day"] stringValue];
                         w.Min=[[temp valueForKey:@"min"]stringValue];
                         w.Max=[[temp valueForKey:@"max"] stringValue];
                         w.Night=[[temp valueForKey:@"night"]stringValue];
                         w.Eve=[[temp valueForKey:@"eve"] stringValue];
                         w.Morn=[[temp valueForKey:@"morn"] stringValue];
                         
                         NSArray *weat =[dict valueForKey:@"weather"];
                         for (NSDictionary *wea in weat)
                         {
                             w.Main=[wea valueForKey:@"main"] ;
                             w.Desc=[wea valueForKey:@"description"] ;
                             w.imgViewWe=[wea valueForKey:@"icon"] ;
                         }
                         
                         [self.DataArray addObject:w];
                     }
                     [self.tableView reloadData];
                     [activityIndicator setHidden:YES];

                 }
                     //[delegate receivedData:data];
                     else if ([data length] == 0 && error == nil)
                     {
                         
                     }
                 
                     else if (error != nil )
                     {
                         
                     }
                 
                 
                 
             }];
  
        }
        
//    }else
//    {
//        lat=[NSString stringWithFormat:@"%f",self.locationData.coordinate.latitude];
//        lon=[NSString stringWithFormat:@"%f",self.locationData.coordinate.longitude];
//        
//        NSString*str=[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=14&APPID=e5a3cda4d2ab4a53826af39ae14ed025",lat,lon];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//        
//        
//        NSLog(@"%@",[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&APPID=e5a3cda4d2ab4a53826af39ae14ed025",lat,lon]);
//        
//        
//        // Create url connection and fire request
//        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        [conn start];
//
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated ];
    NSLog(@"%@",self.cityNames);
    self.navigationController.navigationItem.title=self.cityNames;
    self.title=self.cityNames;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    WeatherCelll *cell=(WeatherCelll *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Weather *w=(Weather*)[self.DataArray objectAtIndex:indexPath.row];
    
    if (cell!=nil) {
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imgViewWe];
       // NSLog(@"%@",w.Date);
        cell.lblCity.text=w.City;
        cell.lblDate.text=w.Date;
        cell.lblDay.text=w.Day ;
        cell.lblMin.text=w.Min ;
        cell.lblMax.text=w.Max ;
        cell.lblEve.text=w.Eve ;
        cell.lblNight.text=w.Night ;
         cell.lblMorn.text=w.Morn ;
        
        cell.lblMain.text=w.Main ;
        cell.lblDesc.text=w.Desc;
        cell.imgViewWe.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",w.imgViewWe]];
        //NSLog(@"%@",[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",w.imgViewWe]);
      

        
    }
    
      return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
