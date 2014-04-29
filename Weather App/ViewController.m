//
//  ViewController.m
//  Weather App
//
//  Created by PMStek07 on 29/04/14.
//  Copyright (c) 2014 swapnil. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
 int flag;
}

@end

@implementation ViewController
@synthesize txtCity;
NSString *city;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCurrentLocation:(id)sender {
    
     flag=1;
    [self getCityName];
  
    
    //NSLog(@"%@",city);
    if (city==nil) {
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"Can not roconize your location please try again"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        
    }else
    [self performSegueWithIdentifier:@"currentSegue" sender:self];
   
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self.txtCity resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [self.txtCity resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
   DetailsViewController *view=(DetailsViewController*) [segue destinationViewController];
    if (flag==1) {
                NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSURL *url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=e5a3cda4d2ab4a53826af39ae14ed025",city]] ;
        [arr addObject:url];
         view.City=[arr mutableCopy];
        view.cityNames=city;
    
       
    }else
    {
        view.locationData=nil;
        view.cityNames=self.txtCity.text;
     NSArray *test=  [self.txtCity.text componentsSeparatedByString:@"," ];
        NSMutableArray *arr=[[NSMutableArray alloc]init];
    for(NSString* str in test)
    {
        NSURL *url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=e5a3cda4d2ab4a53826af39ae14ed025",str]] ;
        [arr addObject:url];
    }
        view.City=[arr mutableCopy];
    }
}
- (IBAction)actionDone:(id)sender {
    flag=0;
    [self performSegueWithIdentifier:@"currentSegue" sender:self];

}

-(void)getCityName
{
    //    Lat=@"33.75134190";
    //    Long=@"-117.99399210";
    AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *Lat=[NSString stringWithFormat:@"%f", app.currentLocation.coordinate.latitude];
   NSString *Long=[NSString stringWithFormat:@"%f", app.currentLocation.coordinate.longitude];

    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",Lat,Long]];
    //NSLog(@"%@",url);
    NSData* data = [NSData dataWithContentsOfURL:
                    url];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSMutableArray *adrress=[[NSMutableArray alloc]init];
    NSMutableArray *subAdrress=[[NSMutableArray alloc]init];
    adrress=[json objectForKey:@"results"];
    if (adrress.count!=0) {
   
    subAdrress=[[adrress objectAtIndex:0] objectForKey:@"address_components"];
    //NSLog(@"%@",subAdrress);
    
    NSString *loc=@"locality";
    
    NSMutableArray *check=[[NSMutableArray alloc]init];
    BOOL a=FALSE;
    for (int m=0; m<[subAdrress count]; m++)
    {
        check=[[subAdrress objectAtIndex:m] objectForKey:@"types"];
       // NSLog(@"%@",check);
        for (int p=0; p<[check count]; p++)
        {
            if ([loc isEqualToString:[check objectAtIndex:p]] )
            {
                city=[[subAdrress objectAtIndex:m] objectForKey:@"long_name"];
                NSLog(@"city.....= %@",city);
               // locationLabel.text=city;
                a=TRUE;
            }
            
            break;
        }
        if (a==TRUE) {
            break;
        }
        
    }
    }else
    {
        city=nil;
    }
}
@end
