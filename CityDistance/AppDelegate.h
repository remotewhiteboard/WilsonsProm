//
//  AppDelegate.h
//  CityDistance
//
//  Created by JohnCakes on 29/09/13.
//  Copyright (c) 2013 JohnCakes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Engine.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"


#import "mapiPad.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,RESideMenuDelegate>{
    
    
    CLLocationManager *locationManager;
    Engine* myEngine;
    
    bool gotValue;
    
    float lastFloat,lastSince;
    NSMutableArray* allPoints;
    NSString* projname;
    
    mapiPad *controller;
    
}
@property (strong, nonatomic) UIWindow *window;

@end
