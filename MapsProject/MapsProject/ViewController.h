//
//  ViewController.h
//  MapsProject
//
//  Created by Nishigandha on 6/15/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<
MKLocalSearchCompleterDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputPlace;
@property (weak, nonatomic)  IBOutlet MKMapView *mapView;

@property (strong, nonatomic) MKLocalSearchCompleter * completer;

@property(weak, nonatomic) IBOutlet UITableView * autoCompleteSearchTable;
@end


