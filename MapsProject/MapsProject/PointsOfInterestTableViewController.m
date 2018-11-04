//
//  PointsOfInterestTableViewController.m
//  MapsProject
//
//  Created by Nishigandha on 6/17/17.
//  Copyright © 2017 Nishigandha. All rights reserved.
//

#import "PointsOfInterestTableViewController.h"
#import "PointsOfInterestCell.h"
#import "ListPlacesTableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "PlaceInformation.h"
#import <AddressBookUI/AddressBookUI.h>
#import "PlaceInformationTableViewCell.h"

@interface PointsOfInterestTableViewController ()

@end

@implementation PointsOfInterestTableViewController {
    NSArray * points;
    NSArray * pointImage;
    NSInteger selectedRowIndex;
    AppDelegate * delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Categories";
    points = @[@"Restaurants",@"Shopping",@"Gas Station",@"Movie Theatre",@"Coffee"];
    pointImage = @[@"reataurant",@"shopping",@"gas",@"movie",@"coffee"];
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.places = [[NSMutableArray alloc]init];
    NSLog(@"Location: %@",delegate.currentLocation);
    NSLog(@"current location %f %f",delegate.currentLocation.coordinate.latitude,delegate.currentLocation.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [points count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PointsOfInterestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interest" forIndexPath:indexPath];
    
    cell.displayLabel.text = points[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:pointImage[indexPath.row]];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"details"]) {

          NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
 
        ListPlacesTableViewController * destination = (ListPlacesTableViewController*)[segue destinationViewController];
            destination.navigationItem.title = points[indexPath.row];
        destination.filter  = points[indexPath.row];
                NSLog(@"Prepare for segue");
    }
}


@end
