//
//  Engine.m
//  NFLNews
//
//  Created by John Lyons on 26/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Engine.h"


@implementation Engine
static Engine *_sharedInstance;
@synthesize saveGames,ourMoves,lat,lon;

@synthesize locationManager;
- (id) init
{
	if (self = [super init])
	{
		// custom initialization
		memset(board, 0, sizeof(board));
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString* documentsDirectory = [paths objectAtIndex:0];
		saveGames = [[NSMutableArray alloc] initWithContentsOfFile:
                     [documentsDirectory stringByAppendingString:@"/saveGames.plist"]];
        
        if ([saveGames count]==0){
            saveGames=[[NSMutableArray alloc] init];
        }
        
        /*
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; // send loc updates to myself
        self.locationManager.distanceFilter = 50.0f;
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
        */
        
        lat=-38.9166667;
        lon=146.3311393;
        board[0]=lat;
        board[1]=lon;
	}
	return self;
}

+ (Engine *) sharedInstance
{
	if (!_sharedInstance)
	{
		_sharedInstance = [[Engine alloc] init];
	}
	
	return _sharedInstance;
}

- (float) getFieldValueAtPos:(NSUInteger)x
{
	return board[x];
}

- (void) setFieldValueAtPos:(NSUInteger)x ToValue:(float)newVal
{
	board[x] = newVal;
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error{
    
	NSString* e=[error description];
	//NSLog(@"Error: %@", [error description]);
	NSRange r=[e rangeOfString:@"(kCLErrorDomain error 1.)"];
	
	if (r.location!=NSNotFound){
		//fail=0;
		//skip=0;
		
		UIAlertView *baseAlert = [[UIAlertView alloc]
								  initWithTitle:@"Error getting GPS"
								  message:@"You need to enable GPS or Wifi"
								  delegate:self cancelButtonTitle:nil
								  otherButtonTitles:@"Retry",@"Skip", nil];
		[baseAlert show];
	}
	
	
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	
	//float yyy=[myEngine getFieldValueAtPos:3];
	
	CLLocationCoordinate2D locs2d=[newLocation coordinate];
	NSLog(@"lat %f",lat);
    lat=locs2d.latitude;
    lon=locs2d.longitude;
    board[0]=lat;
    board[1]=lon;
    accuracy=[newLocation horizontalAccuracy];
    
}
-(void)save:(NSString*)reg :(NSString*)text{
    [saveGames addObject:text];
    [saveGames addObject:reg];
    [saveGames addObject:[NSDate date]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	[saveGames writeToFile:[[paths objectAtIndex:0] stringByAppendingString:@"/saveGames.plist"] atomically:YES];

}
-(float)getDistance:(float)l2 :(float)lo2{
	float dLat,dLon,a;
    float lat1=lat,longi1=lon;
	
	//NSLog(@"dist %f %f   %f %f",lat,lat1,lon,longi1);
	
	
	dLat = (lat1-l2)* M_PI / 180;
	dLon = (longi1-lo2)* M_PI / 180;
	//NSLog(@"lat1 %f, %f",dLat,dLon);
	a = sin(dLat/2) * sin(dLat/2) +cos(l2* M_PI / 180) * cos(lat1* M_PI / 180) * sin(dLon/2) *sin(dLon/2);
	
	return 6378.137  * 2 * atan2(sqrt(a), sqrt(1-a));
	
}
@end
