//
//  Engine.h
//  NFLNews
//
//  Created by John Lyons on 26/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Engine : NSObject <CLLocationManagerDelegate>{
	float board[10];  // c-style array
    
	NSMutableArray* saveGames,*ourMoves;
	CLLocationManager *locationManager;
    float lat,lon,accuracy;
}
@property (nonatomic, readwrite, retain) NSMutableArray *saveGames,*ourMoves;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (readwrite, assign) float lat,lon;


+ (Engine *) sharedInstance;

- (float) getFieldValueAtPos:(NSUInteger)x;
- (void) setFieldValueAtPos:(NSUInteger)x ToValue:(float)newVal;

-(void)save:(NSString*)reg :(NSString*)text;

-(float)getDistance:(float)l2 :(float)lo2;

@end
