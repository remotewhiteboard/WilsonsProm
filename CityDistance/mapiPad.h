//
//  mapiPad.h
//  instantMaps
//
//  Created by John Lyons on 13/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Engine.h"
#include <QuartzCore/QuartzCore.h>

@interface mapiPad : UIViewController <UITextFieldDelegate, UIPopoverControllerDelegate,UINavigationControllerDelegate ,UIImagePickerControllerDelegate,MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate>{
	int width,height;
    
    Engine* myEngine;
    MKMapView* mymapView;
    NSArray* iconType;
    NSMutableArray* captured;
    bool finish;
    
    float closeNum[10],tdfloat[100];
    UIImagePickerController* imagePickerController,*camPickerController;
    int searchClose[10];
    
    UIButton* infoButt;
    
    UITextField* searchLabel;
    NSString* imageName;
    UILabel* statusLabel,*catLabel;
    UIButton* imageView;
    
    UIView* floatLabel,*popView;;
    NSInteger selected,capSelected;
    bool locset;
    
    UIView* graphView,*selectView;
    UITableView* myTableView;
    
    NSMutableArray* moves;
    
    int showStages;
    UIScrollView* myscrolly;
    NSInteger failLoad,lastgetCount;
    NSMutableArray* cityList;
    
    UIView* wetInfo;
    
    NSArray* POI;
	
}
@property (nonatomic, readwrite, retain) NSString *url;

@end
