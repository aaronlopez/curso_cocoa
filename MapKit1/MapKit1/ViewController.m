//
//  ViewController.m
//  MapKit1

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mymap;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKCoordinateRegion region;
	region.center=CLLocationCoordinate2DMake(41.376132, 2.182653);
    MKCoordinateSpan span;
	span.latitudeDelta=.1;
	span.longitudeDelta=.1;
	region.span=span;
	[self.mymap setRegion:region animated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)changeMap:(id)sender{

    UISegmentedControl *seg=sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.mymap setMapType:MKMapTypeStandard];
            break;
        case 1:
            [self.mymap setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [self.mymap setMapType:MKMapTypeHybrid];
            break;
        default:
             [self.mymap setMapType:MKMapTypeHybrid];
            break;
    }


}
@end
