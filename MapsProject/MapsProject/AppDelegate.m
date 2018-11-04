//
//  AppDelegate.m
//  MapsProject
//
//  Created by Nishigandha on 6/15/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

#import "AppDelegate.h"
@import GooglePlaces;
@import GooglePlacePicker;
#import <MapKit/MapKit.h>
#import <AddressBookUI/AddressBookUI.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
        if([GMSPlacesClient provideAPIKey:@"AIzaSyBwAnWWUhYUhYVbXxzR5PehhtP-NBbrZ5w"]) {
            self.placeClient = [GMSPlacesClient sharedClient];
    }
    [GMSServices provideAPIKey:@"AIzaSyBwAnWWUhYUhYVbXxzR5PehhtP-NBbrZ5w"];
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    self.places = [[NSMutableArray alloc] init];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.manager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.manager stopUpdatingLocation];
    self.currentLocation = [locations lastObject];
    NSLog(@"Location: %@",self.currentLocation);
    NSLog(@"current location %f %f",self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude);
}

@end
