//
//  DEMOMenuViewController.h
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "Engine.h"  

@interface DEMOLeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    
    NSArray *titles,*images;
    
    
    UILabel *dateLabel,*dateLabel2;
    UIImageView* flagImage;
    UILabel* mainName,*subName;
    
    Engine* myEngine;
    NSArray* weatherTranslation;
    
    UILabel *weatherLabel,*weatherLabel2,*weatherLabel3,*timeLabel;
    UIImageView* imgWeather;
}

-(void)upDate;
@end
