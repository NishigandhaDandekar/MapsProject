//
//  ListPlacesTableViewController.m
//  MapsProject
//
//  Created by Nishigandha on 6/17/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

#import "ListPlacesTableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "PlaceInformation.h"
#import <AddressBookUI/AddressBookUI.h>
#import "PlaceInformationTableViewCell.h"
#import <MapKit/MapKit.h>
@interface ListPlacesTableViewController ()

@end

@implementation ListPlacesTableViewController{
    AppDelegate * delegate;
    NSMutableArray<PlaceInformation *> * temp;
    }
-(void)setFilter:(NSString *)filter {
    _filter = filter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.manager.delegate =self;
    [delegate.manager startUpdatingLocation];
    temp = [[NSMutableArray<PlaceInformation*> alloc]init];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = _filter;
    request.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(delegate.currentLocation.coordinate.latitude, delegate.currentLocation.coordinate.longitude), MKCoordinateSpanMake(0.5, 0.5));
    MKLocalSearch * search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            PlaceInformation * place = [[PlaceInformation alloc]init];
            place.name=obj.name;
            NSString * streetAddress = ABCreateStringWithAddressDictionary(obj.placemark.addressDictionary,YES);

            streetAddress = [streetAddress stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
            place.address = streetAddress;
            place.location = obj.placemark.location;
            place.url = obj.url;
            place.location = obj.placemark.location;
            [temp  addObject:place];
            [self.tableView reloadData];
        }];

        [self.tableView reloadData];
    }];

}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [delegate.manager stopUpdatingLocation];
    delegate.currentLocation = [locations lastObject];
}

-(void)viewWillAppear:(BOOL)animated {
}
-(void)viewDidAppear:(BOOL)animated {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setPlaces:(NSMutableArray<PlaceInformation *> *)places {
    _places = places;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([temp count]>0){
        return [temp count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeInformationCell" forIndexPath:indexPath];
    cell.title.text = temp[indexPath.row].name;
    cell.address.text = temp[indexPath.row].address;
    cell.direction.tag = indexPath.row;

    [cell.direction addTarget:self action:@selector(getDirections:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void) getDirections : (UIButton*)sender {
    PlaceInformation * placeTemp = temp[sender.tag];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:placeTemp.location.coordinate addressDictionary:nil] ;
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:placeTemp.name];
    [mapItem openInMapsWithLaunchOptions:nil];
}
@end
