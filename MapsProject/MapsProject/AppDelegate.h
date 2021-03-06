//
//  AppDelegate.h
//  MapsProject
//
//  Created by Nishigandha on 6/15/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GooglePlaces;
@import GooglePlacePicker;
#import "PlaceInformation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) GMSPlacesClient *placeClient;
@property (strong,nonatomic) CLLocationManager * manager;
@property (strong,nonatomic) CLLocation * currentLocation;
@property(strong,nonatomic)   NSMutableArray <PlaceInformation*>* places;

@end

