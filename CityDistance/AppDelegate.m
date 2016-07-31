//
//  AppDelegate.m
//  CityDistance
//
//  Created by JohnCakes on 29/09/13.
//  Copyright (c) 2013 JohnCakes. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    myEngine=[Engine sharedInstance];
    
    controller = [[mapiPad alloc] init] ;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewScaleValue=1.0f;
    sideMenuViewController.parallaxEnabled=false;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    
    
    

    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     NSLog(@"applicationWillEnterForeground2");
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        
    return true;
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
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
                                  otherButtonTitles:@"Retry",@"Skip", nil] ;
        [baseAlert show];
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    CLLocationCoordinate2D locs2d=[newLocation coordinate];
    [myEngine setFieldValueAtPos:0 ToValue:locs2d.latitude];
    [myEngine setFieldValueAtPos:1 ToValue:locs2d.longitude];
    [myEngine setFieldValueAtPos:2 ToValue:[newLocation horizontalAccuracy]];
    [myEngine setFieldValueAtPos:3 ToValue:0.0f];
    
    
    //NSLog(@"last %f %f",lastFloat,locs2d.latitude);
    
    if (!gotValue){
        lastFloat=locs2d.latitude;
        gotValue=YES;
        //  [myAtms doCalc];
    } else if (lastFloat!=locs2d.latitude){
        
        float since=[NSDate timeIntervalSinceReferenceDate];
        //NSLog(@"since %f %f %f",since,lastSince,since-lastSince);
        if (since-lastSince>30.0f){
            lastSince=since;
            lastFloat=locs2d.latitude;
            // [myAtms doCalc];
        }
        
    }
    
}
@end
