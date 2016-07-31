    //
//  mapiPad.m
//  instantMaps
//
//  Created by John Lyons on 13/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mapiPad.h"
#import "ParkPlaceMark.h"

@implementation mapiPad

@synthesize url;


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
		
    myEngine=[Engine sharedInstance];
    
	
    CGRect r=[[UIScreen mainScreen] bounds];
    
    captured=[NSMutableArray new];
    
    width=r.size.width;height=r.size.height;
	
	UIView *contentView = [[UIView alloc] initWithFrame:r];
	contentView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	contentView.autoresizesSubviews=YES;
	self.view = contentView;
	//[[ self navigationController] setNavigationBarHidden:YES animated:NO ];
    
    r.size.height=r.size.height+r.origin.y;
    r.origin.y=0;
    
    locset=NO;
    selected=-1;
    
    iconType=[NSArray arrayWithObjects:@"01d",@"clear",@"02d",@"partlycloudy",@"03d",@"cloudy",@"04d",@"scatteredclouds",@"09d",@"partysunnyrain",@"10d",@"rain03",@"11d",@"thunderstorms01",@"13d",@"cloundysnow",@"50d",@"fog",
              
              @"01n",@"clearnight",@"02n",@"partlycloundynight",@"03n",@"cloudynight",@"04n",@"scatteredclouds",@"09n",@"rain01",@"10n",@"rain03",@"11n",@"thunderstorms01",@"13n",@"cloundysnow",@"50n",@"fog",
              
              nil];
    
    /*
    UILabel* tmpLabel;
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,1024,100)];
    tmpLabel.tag = 24;
    tmpLabel.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    tmpLabel.alpha=1;
    [self.view addSubview:tmpLabel];
    
    */
    
    
    POI=[NSArray arrayWithObjects:
         @"Car park",@"146.3558974676",@"-39.0325855091",@"0",@"",
         @"Car park",@"146.3213368692",@"-39.030814413",@"0",@"",
         @"Hike-in campground Oberon Bay",@"146.3442860171",@"-39.0719800349",@"19",@"p1070855-turquoise-water-at-little-oberon-bay.jpg",
         @"Hike-in campground Refuge Cove",@"146.4657220244",@"-39.0434779599",@"45",@"",
         @"Hike-in campground Roaring Meg",@"146.3871020358",@"-39.1157919914",@"165",@"meg.jpg",
         @"Hike-in campground Sealers Cove",@"146.4435150102",@"-39.0225080308",@"35",@"",
         @"Picnic table",@"146.4244190231",@"-39.1298369598",@"119.563484",@"",
         @"Picnic table",@"146.3239920046",@"-39.0286079608",@"6",@"",
         @"Halfway Hut",@"146.3837589975",@"-39.0852719732",@"133",@"half-way-hut-wilsons-promontory.jpg",
         @"Information",@"146.3213368692",@"-39.030814413",@"0",@"",
         @"Junction Little Waterloo Bay Track",@"146.3783629797",@"-39.0753779747",@"67",@"waterloo-bay.jpg",
         @"Kersops Peak Track Junction",@"146.4647710137",@"-39.0507409628",@"196",@"heroImage.jpg",
         @"Lighthouse Track Junction",@"146.4194799867",@"-39.1232290026",@"97",@"p1090821.jpg",
         @"Little Waterloo Bay",@"146.4310529642",@"-39.0649900306",@"31",@"IMG_0450.jpg,waterloobay.jpg",
         @"Refuge Cove",@"146.4604961593",@"-39.0364106745",@"68",@"the-cove2-smaller.jpg,RefugeCove-9.jpg",
         @"Sealers Cove",@"146.4364937413",@"-39.020520011",@"3.44140625",@"0074_001.jpg,refuge_cove_beach.jpg",
         @"Telegraph Track Junction",@"146.3777409587",@"-39.0744670294",@"63",@"next-to-ob-showing-ob.jpg",
         @"Waterloo Bay Track Junction",@"146.4271770045",@"-39.0708390065",@"30",@"",
         @"Wilsons Promontory Lighthouse",@"146.4243910275",@"-39.1298239678",@"120",@"",
         @"Toilet disabled flushing",@"146.3213368692",@"-39.030814413",@"0",@"",
         @"Toilet drop",@"146.3558974676",@"-39.0325855091",@"0",@"",
         @"Toilet drop",@"146.4436030202",@"-39.0224890038",@"36",@"",
         @"Toilet drop",@"146.464058971",@"-39.0423279628",@"54",@"",
         @"Toilet drop",@"146.4659530297",@"-39.0436190274",@"43",@"",
         @"Toilet drop",@"146.4303900395",@"-39.065025989",@"31",@"",
         @"Toilet drop",@"146.3867749739",@"-39.1155599803",@"167",@"",
         @"Toilet drop",@"146.3837849814",@"-39.085266022",@"132",@"",
         @"Toilet drop",@"146.3441379927",@"-39.071294982",@"18",@"",
         @"Toilet flushing",@"146.4244083781",@"-39.1298306733",@"118.845024",@"",
         @"Water point unreliable",@"146.4443869796",@"-39.022752028",@"44",@"",
         @"Water point unreliable",@"146.4657739922",@"-39.0435359627",@"44",@"",
         @"Water point unreliable",@"146.4354040101",@"-39.062749967",@"72",@"",
         @"Water point unreliable",@"146.4303799812",@"-39.0650150087",@"30",@"",
         @"Water point unreliable",@"146.4213459659",@"-39.1078819893",@"119",@"",
         @"Water point unreliable",@"146.3878750149",@"-39.1156909894",@"152",@"",
         @"Water point unreliable",@"146.3840210158",@"-39.0850709751",@"130",@"",
         @"Water point unreliable",@"146.3440990169",@"-39.0712249931",@"15",@"",
         @"Dannevig Island",@"146.1683757",@"-39.1055245",@"",@"Citadel McHugh and Dannevig Islands.jpg",
         @"Great Glennie island",@"146.2116773",@"-39.0840749",@"",@"Great Glennie.jpg,Great Glennie Island 2.jpg,Great Glennie Island.jpg,Great Glennie Island 3.jpg,Sea Cave Great Glennie Island.jpg",
         @"Five Mile Beach",@"146.4295392",@"-38.9541117",@"",@"LeopardSealFiveMileBeach.jpg",
         @"Kanowna Island",@"146.2891856",@"-39.1520006",@"",@"Kanowna Island and Cleft Island.jpg,Rainbow over Kanowna Island.jpg,Cape Barron Goose and Cleft Island.jpg",
         @"Skull Rock Island",@"146.292472",@"-39.1576292",@"",@"Cleft Island or Skull Rock.jpg,Sunset over Cleft Island.jpg,Cleft Island and Anderson Islets by Michael Sale.jpg",
         @"Anderson Islets",@"146.296797",@"-39.1550178",@"",@"Anderson Islets.jpg",
         @"Kanowna Island",@"146.3068257",@"-39.1543254",@"",@"Kanowna Island 2.jpg,Kanowna Island looking over Anser Island and the Prom.jpg",
         @"millers landing ",@"146.3011356",@"-38.9052585",@"",@"704192.jpg,704194.jpg,704193.jpg",
         @"Vereker Lookout",@"146.3149544",@"-38.9217543",@"",@"10-wilsons-promontory-mills-landing.jpg",
         @"Corner Island",@"146.3167675",@"-38.8852347",@"",@"CornerInlet.jpg", nil];
    
    
    mymapView=[[MKMapView alloc] initWithFrame:r];
   // mymapView.showsUserLocation=TRUE;
    mymapView.mapType=MKMapTypeStandard;
    mymapView.delegate=self;
    //mymapView.zoomEnabled=NO;
    //mymapView.scrollEnabled=NO;
    mymapView.tag=177;
    [self.view addSubview:mymapView];
    
    
    
    MKCoordinateSpan span;
    
    span.latitudeDelta=0.6f;
    span.longitudeDelta=0.6f;
    
    CLLocationCoordinate2D location;
    location.latitude=-38.9166667,location.longitude=146.3311393;
    
    MKCoordinateRegion reg;
    reg.center=location;
    reg.span=span;
    
    [mymapView setRegion:reg animated:YES];
    
    
    [self showPOI];
    
    
    
     infoButt=[UIButton buttonWithType:UIButtonTypeCustom];
    infoButt.frame=CGRectMake(width,200,90,90);
    infoButt.tag=102;
    infoButt.adjustsImageWhenHighlighted=YES;
    [infoButt setBackgroundImage:[UIImage imageNamed:@"infoButt.png"] forState:UIControlStateNormal];
    [infoButt addTarget:self action:@selector(goAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButt];
    
    /*
    UIButton* addButt2=[UIButton buttonWithType:UIButtonTypeCustom];
	addButt2.frame=CGRectMake(768-95,5,90,90);
    addButt2.tag=102;
	addButt2.adjustsImageWhenHighlighted=YES;
	[addButt2 setBackgroundImage:[UIImage imageNamed:@"addOra.png"] forState:UIControlStateNormal];
	[addButt2 addTarget:self action:@selector(goAdd) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:addButt2];
    
    addButt2=[UIButton buttonWithType:UIButtonTypeCustom];
	addButt2.frame=CGRectMake(768-195,5,90,90);
    addButt2.tag=103;
	addButt2.adjustsImageWhenHighlighted=YES;
	[addButt2 setBackgroundImage:[UIImage imageNamed:@"starOra.png"] forState:UIControlStateNormal];
	[addButt2 addTarget:self action:@selector(goBook) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:addButt2];
    
    searchLabel=[[UITextField alloc] initWithFrame:CGRectMake(10,10,528,40)];
	//[textLabel setText:@"Name"];
	//textLabel.backgroundColor=[UIColor clearColor];
	searchLabel.textColor = [UIColor blackColor];
    searchLabel.tag=33;
    searchLabel.clearButtonMode=UITextFieldViewModeAlways;
	searchLabel.autocorrectionType=UITextAutocorrectionTypeNo;
	[searchLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	searchLabel.borderStyle=UITextBorderStyleRoundedRect;
	//textLabel.keyboardType=UIKeyboardTypeNumberPad;
	searchLabel.delegate=self;
	[searchLabel setFont: [UIFont fontWithName:@"Helvetica" size:26]];
	[self.view addSubview:searchLabel];
*/
    
   // [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(checkLoc) userInfo:nil repeats:YES];

    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(checkLoc) userInfo:nil repeats:NO];
    
    
    UIImageView *picTemp = [[UIImageView alloc] init];
    picTemp.frame= CGRectMake(5,20,80,80);
    picTemp.tag=20;
    picTemp.image=[UIImage imageNamed:@"wmap2-80"];
    [self.view addSubview:picTemp];


     //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkLoad) userInfo:nil repeats:YES];
    
    
    wetInfo=[[UIView alloc] initWithFrame:CGRectMake(width, height-150, width, 150)];
    wetInfo.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:wetInfo];
    
    
    {
        popView=[[UIView alloc] initWithFrame:CGRectMake(0, r.size.height, width, 100)];
        [self.view addSubview:popView];
        
        UIImageView* catView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
        catView.image=[UIImage imageNamed:@"wilsonIcon.png"];
        [popView addSubview:catView];
        
        UIImageView* anView = [[UIImageView alloc] initWithFrame:CGRectMake(105,5, r.size.width-110, 90)];
        anView.tag=310;
        anView.image=[[UIImage imageNamed:@"whiteBlockSM.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [popView addSubview:anView];
        
        
        catLabel = [[UILabel alloc] initWithFrame:CGRectMake(115,14, r.size.width-130, 72)];
        catLabel.text=@"Enter your purchase below, and leave a note. ";
        catLabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        catLabel.textColor=[UIColor darkGrayColor];
        catLabel.numberOfLines = 4;
        catLabel.lineBreakMode = NSLineBreakByWordWrapping;
        catLabel.textAlignment=NSTextAlignmentLeft;
        catLabel.backgroundColor=[UIColor clearColor];
        [popView addSubview:catLabel];
        
    }
    
    
    
    UIImageView *picTem2p = [[UIImageView alloc] init];
    picTem2p.frame= CGRectMake(0,0,375,674);
    picTem2p.tag=20;
    picTem2p.image=[UIImage imageNamed:@"wall.png"];
    [self.view addSubview:picTem2p];
    
    [UIView animateWithDuration:0.2f
                          delay: 2.0
                        options: UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         picTem2p.frame= CGRectMake(-width,0,375,674);
                     }
                     completion:^(BOOL finished){
                         [picTem2p removeFromSuperview];
                     }];

}
-(void)checkLoc{
    float lat=[myEngine getFieldValueAtPos:0];
    if (lat==0.0f){
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkLoc) userInfo:nil repeats:NO];
    } else {
        [self checkDist];
    }
    
}
-(void)checkDist{
    
    float totX=[myEngine getFieldValueAtPos:0];
    float totY=[myEngine getFieldValueAtPos:1];
    
    
    double lat1,longi1,dLat,dLon,a;
    
    for ( int i=0; i<POI.count; i=i+5) {
       // NSString* name=[POI objectAtIndex:i];
        NSString* pic=[POI objectAtIndex:i+4];
        
        if (pic.length>0){
            // [cityList addObject:name];
            
            
            lat1=[[POI objectAtIndex:i+2] floatValue];
            longi1=[[POI objectAtIndex:i+1] floatValue];
            //NSLog(@"loc %f %f",location2.latitude,location2.longitude);
            
            dLat = (lat1-totX)* M_PI / 180;
            dLon = (longi1-totY)* M_PI / 180;
            //NSLog(@"lat1 %f, %f",dLat,dLon);
            a = sin(dLat/2) * sin(dLat/2) +cos(totX* M_PI / 180) * cos(lat1* M_PI / 180) * sin(dLon/2) *sin(dLon/2);
            
            float distance=6378.137  * 2 * atan2(sqrt(a), sqrt(1-a));
            
            tdfloat[i/2]=distance;

        }
        
    }
    
    
    float last=99999.0f;
    float ddd;
    
    
    for (int i=0;i<10;i++){
        int num=0;
        last=99999.0f;
        
        for ( int j=0; j<POI.count; j=j+5) {
            ddd=tdfloat[j/5];
            
            if (ddd<last){
                if (ddd!=0.0f){
                    last=ddd;
                    num=j/5;
                }
                
            }
        }
        //NSLog(@"i %i %f %i",i,tdfloat[num],num);
        closeNum[i/5]=tdfloat[num];
        tdfloat[num]=99999.0f;
        searchClose[i/5]=num;
        
    }
    
   // NSString* name=[POI objectAtIndex:searchClose[0]*5];
    
    catLabel.text=[@"You are " stringByAppendingFormat:@"%1.1f km away from Wilsons Prom. You can still try the game by clicking around.",closeNum[0]];
    [UIView animateWithDuration:0.2f
                          delay: 0.0
                        options: UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         popView.frame=CGRectMake(0, height-100, width, 100);
                         
                         [UIView animateWithDuration:0.2f
                                               delay: 10.0
                                             options: UIViewAnimationOptionTransitionFlipFromLeft
                                          animations:^{
                                              popView.frame=CGRectMake(-width, height-100, width, 100);
                                          }
                                          completion:^(BOOL finished){
                                              [popView removeFromSuperview];
                                          }];
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];

    
    
   // NSLog(@"close %@ %f",name,closeNum[0]);
    
    
}
-(void)showPOI{
    
    
    [mymapView removeAnnotations:mymapView.annotations];
        failLoad=0;
    
    // NSLog(@"bbox %@",bbox);
    
    
   // MKCoordinateSpan span = mymapView.region.span;
    
        
        NSMutableArray * annots=[[NSMutableArray alloc] init];
        cityList=[[NSMutableArray alloc] init];
        for ( int i=0; i<POI.count; i=i+5) {
            NSString* name=[POI objectAtIndex:i];
            NSString* pic=[POI objectAtIndex:i+4];
            
            
            if (pic.length>0){
               // [cityList addObject:name];
                
                
                
                CLLocationCoordinate2D location2;
                location2.latitude=[[POI objectAtIndex:i+2] floatValue];
                location2.longitude=[[POI objectAtIndex:i+1] floatValue];
                //NSLog(@"loc %f %f",location2.latitude,location2.longitude);
                            ParkPlaceMark* placemark=[[ParkPlaceMark alloc] initWithCoordinate:location2];
                [placemark setTitle:name];
                
                
                [annots addObject:placemark];
                
            }
            
        }
        [mymapView addAnnotations:annots];
    
    
    
}
-(void)goBook{
    graphView = [[UIView alloc] initWithFrame:CGRectMake(width,200, width-200, height-400)];
	//graphView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    graphView.tag=300;
	[self.view addSubview:graphView];
    
    
    UIView* vView = [[UIView alloc] initWithFrame:CGRectMake(0,0,width-200, height-400)];
    vView.backgroundColor=[UIColor whiteColor];
    vView.alpha=1.8f;
    vView.tag=1;
    [graphView addSubview:vView];
    
    vView = [[UIView alloc] initWithFrame:CGRectMake(2,2,width-204,height-404)];
    vView.backgroundColor=[UIColor blackColor];
    vView.tag=4;
    [graphView addSubview:vView];
  
    
    vView = [[UIView alloc] initWithFrame:CGRectMake(4,4,width-208,height-408)];
    vView.backgroundColor=[UIColor whiteColor];
    vView.tag=2;
    [graphView addSubview:vView];
   
    
    
    UIButton* dragger = [[UIButton alloc] initWithFrame:CGRectMake(width-160,160,90,90)];
    [dragger setUserInteractionEnabled:YES];
    dragger.tag=149;
    [dragger addTarget:self action:@selector(closeGraph) forControlEvents:UIControlEventTouchUpInside];
    [dragger setBackgroundImage:[UIImage imageNamed:@"redCross.png"] forState:UIControlStateNormal];
    //dragger.delegate=self;
    [self.view addSubview:dragger];
    
    
    
    [UIView animateWithDuration:0.3f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         graphView.frame=CGRectMake(100,200, width-200, height-400);
                         [self.view viewWithTag:103].frame=CGRectMake(width-175,-100,90,90);
                         [self.view viewWithTag:102].frame=CGRectMake(width-90,-100,90,90);
                     }
                     completion:^(BOOL finished){
                     }];
    
    
    UILabel* tmpLabel;
    
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,4,width-240,30)];
	tmpLabel.tag = 12;
    tmpLabel.text=@"pick a location";
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:22];
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentCenter;
    [graphView addSubview:tmpLabel];
    
    /*
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(5,35,width-210, height-440) style:UITableViewStylePlain];

    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight=100; //100
    myTableView.scrollEnabled=YES;
    myTableView.backgroundColor=[UIColor whiteColor];
    myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.view =myTableView;
    [graphView addSubview:myTableView];
     */

    myscrolly=[[UIScrollView alloc] initWithFrame:CGRectMake(5,35,width-210, height-440)];
    myscrolly.contentSize=CGSizeMake(width-210,700);
    myscrolly.backgroundColor=[UIColor whiteColor];
    myscrolly.tag=111;
    [graphView addSubview:myscrolly];
    [self drawPos];
}
-(void)drawPos{
    //int total=[[myEngine saveGames] count]/3;
    
    int size=(width-210)/3,hsize=size*1024/768;
    
    NSLog(@"size %i %i",size,hsize);
    
    int totes=[[myEngine saveGames] count]/3;
    
    myscrolly.contentSize=CGSizeMake(width-210,totes*hsize);
    
    
    
    for (int i=0;i<[[myEngine saveGames] count];i=i+3){
        
        int tot=i/3;
        
        //NSLog(@"pos %i,%i",tot%3*size,tot/3*hsize);
        
        UIButton *dragger = [[UIButton alloc] initWithFrame:CGRectMake(tot%3*size,tot/3*hsize,size,hsize)];
		[dragger addTarget:self action:@selector(goButt:) forControlEvents:UIControlEventTouchUpInside];
		dragger.tag=i;
		[myscrolly addSubview:dragger];
        
        
        UIImageView *picTemp = [[UIImageView alloc] init];
        picTemp.frame= CGRectMake(5,5,size-10,hsize-10);
        picTemp.tag=20;
        [dragger addSubview:picTemp];
        
        
        NSString* title=[[myEngine saveGames] objectAtIndex:i+0];
        NSString* regd=[[myEngine saveGames] objectAtIndex:i+1];
        
        //Initialize Label with tag 1.
        UILabel* lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size-10,75)];
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:20];
        lblTemp.tag = 1;
        lblTemp.backgroundColor=[UIColor whiteColor];
        lblTemp.alpha=0.7f;
        lblTemp.textAlignment=NSTextAlignmentLeft;
        [dragger addSubview:lblTemp];
       
        /*
        lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(5,5,size-20,40)];
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:30];
        lblTemp.tag = 1;
        lblTemp.textColor = [UIColor blackColor];
        lblTemp.backgroundColor=[UIColor clearColor];
        lblTemp.textAlignment=NSTextAlignmentLeft;
        [dragger addSubview:lblTemp];
        [lblTemp release];
         */
        
        lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(5,5,size-20,40)];
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:20];
        lblTemp.tag = 13;
        lblTemp.text=title;
        lblTemp.textColor = [UIColor blackColor];
        lblTemp.backgroundColor=[UIColor clearColor];
        lblTemp.textAlignment=NSTextAlignmentLeft;
        [dragger addSubview:lblTemp];
     
        NSArray* split=[regd componentsSeparatedByString:@","];
        
        float dist=[myEngine getDistance:[[split objectAtIndex:0] floatValue] :[[split objectAtIndex:1] floatValue]];
        
        NSString* str=[@"" stringByAppendingFormat:@"%1.1fkm",dist];
        
        
        //Initialize Label with tag 2.
        lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(5,45,size-20,26)];
        lblTemp.tag = 2;
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:20];
        lblTemp.textColor=[UIColor darkGrayColor];
        lblTemp.text=str;
        lblTemp.textAlignment=NSTextAlignmentLeft;
        lblTemp.numberOfLines = 3;
        lblTemp.lineBreakMode = UILineBreakModeWordWrap;
        lblTemp.adjustsFontSizeToFitWidth=YES;
        lblTemp.backgroundColor=[UIColor clearColor];
        [dragger addSubview:lblTemp];
    
       
        regd=[regd stringByReplacingOccurrencesOfString:@"," withString:@""];
        regd=[regd stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[@"" stringByAppendingFormat:@"Documents/%@.png",regd]];
        
        picTemp.image=[[UIImage alloc] initWithContentsOfFile:pngPath];

        
        
    }
}
-(void)goButt:(id)sel{
    int tag=[sel tag];
    
    NSString* regd=[[myEngine saveGames] objectAtIndex:tag+1];
    //NSLog(@"title %@ %@",title,regd);
    
    NSArray* split=[regd componentsSeparatedByString:@","];
    
    MKCoordinateSpan span;
    
    span.latitudeDelta=[[split objectAtIndex:2] floatValue];
    span.longitudeDelta=[[split objectAtIndex:3] floatValue];
    
    CLLocationCoordinate2D location;
    location.latitude=[[split objectAtIndex:0] floatValue],location.longitude=[[split objectAtIndex:1] floatValue];
    
    MKCoordinateRegion reg;
    reg.center=location;
    reg.span=span;
    
    [mymapView setRegion:reg animated:YES];
    
    UIView* contentView=[self.view viewWithTag:1000];
    
    [UIView animateWithDuration:0.2f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         contentView.alpha=0.0f;
                     }
                     completion:^(BOOL finished){
                         [contentView removeFromSuperview];
                     }];
    
    
    searchLabel.text=@"";
}
-(void)goAdd{
    MKCoordinateRegion reg=mymapView.region;
    //NSLog(@"reg %@",reg.center);
    
    
    
    graphView = [[UIView alloc] initWithFrame:CGRectMake(width,200, width-200, height-400)];
	//graphView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    graphView.tag=300;
	[self.view addSubview:graphView];
    
    
    UIView* vView = [[UIView alloc] initWithFrame:CGRectMake(0,0,width-200, height-400)];
    vView.backgroundColor=[UIColor whiteColor];
    vView.alpha=1.8f;
    vView.tag=1;
    [graphView addSubview:vView];
  
    vView = [[UIView alloc] initWithFrame:CGRectMake(2,2,width-204,height-404)];
    vView.backgroundColor=[UIColor blackColor];
    vView.tag=4;
    [graphView addSubview:vView];
   
    
    vView = [[UIView alloc] initWithFrame:CGRectMake(4,4,width-208,height-408)];
    vView.backgroundColor=[UIColor whiteColor];
    vView.tag=2;
    [graphView addSubview:vView];
   
    
    
    UIButton* dragger = [[UIButton alloc] initWithFrame:CGRectMake(width-160,160,90,90)];
    [dragger setUserInteractionEnabled:YES];
    dragger.tag=149;
    [dragger addTarget:self action:@selector(closeGraph) forControlEvents:UIControlEventTouchUpInside];
    [dragger setBackgroundImage:[UIImage imageNamed:@"redCross.png"] forState:UIControlStateNormal];
    //dragger.delegate=self;
    [self.view addSubview:dragger];
   
    
    [UIView animateWithDuration:0.3f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         graphView.frame=CGRectMake(100,200, width-200, height-400);
                         [self.view viewWithTag:103].frame=CGRectMake(width-175,-100,90,90);
                         [self.view viewWithTag:102].frame=CGRectMake(width-90,-100,90,90);
                     }
                     completion:^(BOOL finished){
                     }];
    
    
    UILabel* tmpLabel;
    
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,20,width-240,40)];
	tmpLabel.tag = 12;
    tmpLabel.text=@"this location";
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:30];
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentCenter;
    tmpLabel.alpha=0.7f;
    [graphView addSubview:tmpLabel];
 
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,120,width-240,40)];
	tmpLabel.tag = 12;
    tmpLabel.text=@"enter a title for this location";
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:30];
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentLeft;
    tmpLabel.alpha=0.7f;
    [graphView addSubview:tmpLabel];

    
    
    UITextField* tField=[[UITextField alloc] initWithFrame:CGRectMake(20,160,width-240,40)] ;
	//[textLabel setText:@"Name"];
	//textLabel.backgroundColor=[UIColor clearColor];
	tField.textColor = [UIColor blackColor];
    tField.tag=99;
    tField.clearButtonMode=UITextFieldViewModeAlways;
	tField.autocorrectionType=UITextAutocorrectionTypeNo;
	//[searchLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	tField.borderStyle=UITextBorderStyleRoundedRect;
	//textLabel.keyboardType=UIKeyboardTypeNumberPad;
	tField.delegate=self;
	[tField setFont: [UIFont fontWithName:@"Helvetica" size:30]];
	[graphView addSubview:tField];
    
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,320,width-240,46)];
	tmpLabel.tag = 12;
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:40];
    tmpLabel.text=[@"" stringByAppendingFormat:@" gps (%f,%f)",reg.center.latitude,reg.center.longitude];
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentCenter;
    tmpLabel.alpha=0.7f;
    [graphView addSubview:tmpLabel];
 
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,400,width-240,46)];
	tmpLabel.tag = 12;
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:40];
    tmpLabel.text=[@"" stringByAppendingFormat:@" lat %f %f",reg.span.latitudeDelta,reg.span.longitudeDelta];
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentCenter;
    tmpLabel.alpha=0.7f;
    [graphView addSubview:tmpLabel];

    
    dragger = [[UIButton alloc] initWithFrame:CGRectMake(50,460,90,90)];
    [dragger setUserInteractionEnabled:YES];
    dragger.tag=151;
    [dragger addTarget:self action:@selector(saveGPS) forControlEvents:UIControlEventTouchUpInside];
    [dragger setBackgroundImage:[UIImage imageNamed:@"grnTick.png"] forState:UIControlStateNormal];
    //dragger.delegate=self;
    [graphView addSubview:dragger];

    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,485,300,40)];
	tmpLabel.tag = 12;
	tmpLabel.font=[UIFont fontWithName:@"Verdana" size:30];
    tmpLabel.text=@"save location";
    tmpLabel.backgroundColor= [UIColor whiteColor];
	tmpLabel.textAlignment=NSTextAlignmentLeft;
    tmpLabel.alpha=0.7f;
    [graphView addSubview:tmpLabel];



}
-(void)saveGPS{
    UITextField* tField=(UITextField*)[graphView viewWithTag:99];
    if ([tField.text length]>0){
    
        MKCoordinateRegion reg=mymapView.region;
        
        
        NSString* regd=[@"" stringByAppendingFormat:@"%f,%f,%f,%f",reg.center.latitude,reg.center.longitude,reg.span.latitudeDelta,reg.span.longitudeDelta];
        
        [myEngine save:regd :tField.text];
        
        [self closeGraph];
        
        //NSLog(@"captureScreen %@",mymapView);
        
        [self captureScreen:mymapView :regd];
    } else {
        
        UIView*dragger=[graphView viewWithTag:99];
        
        [UIView animateWithDuration:0.1 animations:^{dragger.alpha = 1.0;}];
        
        dragger.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
        
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        bounceAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:1.2],
                                  [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:1.1], nil];
        bounceAnimation.duration = 0.3;
        bounceAnimation.delegate=self;
        bounceAnimation.removedOnCompletion = NO;
        [dragger.layer addAnimation:bounceAnimation forKey:@"bounce"];
        
        dragger.layer.transform = CATransform3DIdentity;

    }
    
}
-(void)closeGraph{
    
    [UIView animateWithDuration:0.3f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         graphView.frame=CGRectMake(-width+200,200, width-200, height-400);
                         [self.view viewWithTag:103].frame=CGRectMake(width-175,0,90,90);
                         [self.view viewWithTag:102].frame=CGRectMake(width-90,0,90,90);
                         [self.view viewWithTag:149].frame=CGRectMake(width,160,90,90);
                     }
                     completion:^(BOOL finished){
                         [graphView removeFromSuperview];
                         [[self.view viewWithTag:149] removeFromSuperview];
                     }];

    
}

- (void)viewDidAppear:(BOOL)animated{
	
	
	
}
-(void)getMapWeather{
    failLoad=0;
 //   NSArray* bbox=[self getBoundingBox:mymapView.visibleMapRect];
    
   // NSLog(@"bbox %@",bbox);
    
    
  //  MKCoordinateSpan span = mymapView.region.span;
   // NSLog(@" 1 = ~111 km -> %f = ~ %f km ",span.latitudeDelta,span.latitudeDelta*11);

    float multi=6;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
        multi=11;
    }
    
   /* [weather getCities:bbox :span.latitudeDelta*multi :^(NSArray* cities) {
        
        NSMutableArray * annots=[[NSMutableArray alloc] init];
        cityList=[[NSMutableArray alloc] init];
        for ( int i=0; i<cities.count; i++) {
            NSString* name=[cities objectAtIndex:i];
            NSArray* cityInfo=[weather getDeets:name];
            
         //   NSLog(@"name %@ %@",name,cityInfo);
            [cityList addObject:name];
            
            CLLocationCoordinate2D location2;
            location2.latitude=[[cityInfo objectAtIndex:1] floatValue];
            location2.longitude=[[cityInfo objectAtIndex:2] floatValue];
            
            ParkPlaceMark* placemark=[[ParkPlaceMark alloc] initWithCoordinate:location2];
            [placemark setTitle:name];
            
            
            [annots addObject:placemark];
            
        }
        [mymapView addAnnotations:annots];
    }];*/

    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
   // [self getMapWeather];
    
    
    
    

    
    
    
    if (selected>-1){
        
        UILabel* tmpLabel;
        
        
        capSelected=selected;
        
        float lat1=[[POI objectAtIndex:selected+2] floatValue];
        float longi1=[[POI objectAtIndex:selected+1] floatValue];
        
        float dist=[myEngine getDistance:lat1 :longi1];
        
        NSString* name=[POI objectAtIndex:selected];
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,2,width-40,22)];
        tmpLabel.tag = 12;
        tmpLabel.text=name;
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:20];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        NSInteger findIt=[captured indexOfObject:name];
        
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,24,width-40,16)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"%1.1fkm away from here",dist];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:12];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        
        if (findIt!=NSNotFound){
            
            NSString* imageName=[@"" stringByAppendingFormat:@"cap%i",(int)capSelected];
            
                        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.jpg",imageName];
            
            
            UIImageView *picTemp = [[UIImageView alloc] init];
            picTemp.frame= CGRectMake(0,40,width-0,200);
            picTemp.tag=20;
            picTemp.clipsToBounds=YES;
            picTemp.contentMode=UIViewContentModeScaleAspectFill;
            picTemp.image=[UIImage imageNamed:jpgPath];
            [wetInfo addSubview:picTemp];
            
        } else {
            
        
        NSString*  wetIcon=[POI objectAtIndex:selected+4];
        
        NSArray* split=[wetIcon componentsSeparatedByString:@","];
        if (split.count>1){
            wetIcon=[split objectAtIndex:0];
        }
        wetIcon=[wetIcon stringByReplacingOccurrencesOfString:@"." withString:@"th."];
        
        
        
        
        if (split.count>1){
            
            
           UIScrollView*  scrolly = [[UIScrollView alloc] initWithFrame:CGRectMake(0,40,width-0,200)];
            //contentView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
            //contentView.autoresizesSubviews=YES;
            scrolly.contentSize=CGSizeMake(width*split.count,200);
            scrolly.pagingEnabled=YES;
            scrolly.backgroundColor=[UIColor whiteColor];
            [wetInfo addSubview:scrolly];
            
            for (int i=0; i<split.count; i++) {
                
                wetIcon=[split objectAtIndex:i];
                wetIcon=[wetIcon stringByReplacingOccurrencesOfString:@"." withString:@"th."];
                
                
                UIImageView *picTemp = [[UIImageView alloc] init];
                picTemp.frame= CGRectMake(i*width,0,width-0,200);
                picTemp.tag=20;
                picTemp.clipsToBounds=YES;
                picTemp.contentMode=UIViewContentModeScaleAspectFill;
                picTemp.image=[UIImage imageNamed:wetIcon];
                [scrolly addSubview:picTemp];
            }
            
            
        } else {
            
            UIImageView *picTemp = [[UIImageView alloc] init];
            picTemp.frame= CGRectMake(0,40,width-0,200);
            picTemp.tag=20;
            picTemp.clipsToBounds=YES;
            picTemp.contentMode=UIViewContentModeScaleAspectFill;
            picTemp.image=[UIImage imageNamed:wetIcon];
            [wetInfo addSubview:picTemp];
        }

    }
    
        /*
        
        picTemp = [[UIImageView alloc] init];
        picTemp.frame= CGRectMake(20,40,width-40,200);
        picTemp.tag=20;
        picTemp.clipsToBounds=YES;
        picTemp.contentMode=UIViewContentModeScaleAspectFit;
        picTemp.image=[UIImage imageNamed:@"selectIcon.png"];
        [wetInfo addSubview:picTemp];
        
        */
        UIButton* setButton=[UIButton buttonWithType:UIButtonTypeCustom];
        setButton.frame=CGRectMake(width-60, 0,40,40);
        setButton.tag=100;
        setButton.adjustsImageWhenHighlighted=YES;
        [setButton setBackgroundImage:[UIImage imageNamed:@"redCross.png"] forState:UIControlStateNormal];
        [setButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [wetInfo addSubview:setButton];
        
        
        setButton=[UIButton buttonWithType:UIButtonTypeCustom];
        setButton.frame=CGRectMake(20, 300,80,80);
        setButton.tag=100;
        [setButton setBackgroundColor:[UIColor blueColor]];
        [setButton setImage:[UIImage imageNamed:@"PinkCameraIcon"] forState:UIControlStateNormal];
        setButton.adjustsImageWhenHighlighted=YES;
        [setButton addTarget:self action:@selector(capture) forControlEvents:UIControlEventTouchUpInside];
        [wetInfo addSubview:setButton];
        
        
        /*
        
        imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        imageView.frame=CGRectMake(0,40,width,200);
        [imageView setBackgroundColor:[UIColor clearColor]];
       // [imageView setImage:[UIImage imageNamed:@"PinkCameraIcon"] forState:UIControlStateNormal];
        [imageView.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
       // [imageView addTarget:self action:@selector(capture) forControlEvents:UIControlEventTouchUpInside];
        [wetInfo addSubview:imageView];*/
        
        [UIView animateWithDuration:0.3f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         
                         wetInfo.frame=CGRectMake(0, 100, width, 400);
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                     }];
        selected=-1;
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    
	//[self checkOrientation];
    [self goStars];
    
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self checkOrientation];
}
-(void)checkOrientation{
	UIDeviceOrientation toInterfaceOrientation = [[UIDevice currentDevice] orientation];
	
	//NSLog(@"toInterfaceOrientation %i",toInterfaceOrientation);
	
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight | toInterfaceOrientation == 4)
	{
		//NSLog(@"UIInterfaceOrientationLandscapeRight");
		height=self.view.frame.size.width;
		width=self.view.frame.size.height;
	} else //if (toInterfaceOrientation == UIInterfaceOrientationPortrait | toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		//NSLog(@"UIInterfaceOrientationPortrait");
		width=self.view.frame.size.height;
		height=self.view.frame.size.width;
	}
    
    mymapView.frame=CGRectMake(0,0,width,height);
  //  [self.view viewWithTag:103].frame=CGRectMake(width-175,0,90,90);
   // [self.view viewWithTag:102].frame=CGRectMake(width-90,0,90,90);
	
    
    
    //searchLabel.frame=CGRectMake(10,10,width-210,40);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



#pragma mark UITableView datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	//NSLog(@"pop %i",[[myEngine saveGames] count]);
	return [[myEngine saveGames] count]/3;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"myTableView 5");
	return 1;
	
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
	
	return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
	
	return 0;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NSString* move=[[myEngine saveGames] objectAtIndex:indexPath.row*2];
    //NSLog(@"move %@",move);
    
    //NSString* title=[[myEngine saveGames] objectAtIndex:indexPath.row*3+0];
    NSString* regd=[[myEngine saveGames] objectAtIndex:indexPath.row*3+1];
    //NSLog(@"title %@ %@",title,regd);
    
    NSArray* split=[regd componentsSeparatedByString:@","];
    
    MKCoordinateSpan span;
    
    span.latitudeDelta=[[split objectAtIndex:2] floatValue];
    span.longitudeDelta=[[split objectAtIndex:3] floatValue];
    
    CLLocationCoordinate2D location;
    location.latitude=[[split objectAtIndex:0] floatValue],location.longitude=[[split objectAtIndex:1] floatValue];
    
    MKCoordinateRegion reg;
    reg.center=location;
    reg.span=span;

    [mymapView setRegion:reg animated:YES];
    
    UIView* contentView=[self.view viewWithTag:1000];
    
    [UIView animateWithDuration:0.2f
                          delay: 0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         contentView.alpha=0.0f;
                     }
                     completion:^(BOOL finished){
                         [contentView removeFromSuperview];
                     }];
    
    searchLabel.text=@"";
    //myscrolly.hidden=NO;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 100.0f;
}
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
	UILabel *lblTemp;
	
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
    //int middle=(width-320);
    //int middle=0;
	
	UIImageView *picTemp = [[UIImageView alloc] init];
	picTemp.frame= CGRectMake(5,5,130,80);
	picTemp.tag=20;
	[cell.contentView addSubview:picTemp];

    
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 480, 24)];
	lblTemp.font=[UIFont fontWithName:@"Verdana" size:20];
	lblTemp.tag = 1;
	lblTemp.textColor = [UIColor blackColor];
	lblTemp.backgroundColor=[UIColor whiteColor];
	lblTemp.textAlignment=NSTextAlignmentLeft;
	[cell.contentView addSubview:lblTemp];

	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(140,30,480,60)];
	lblTemp.tag = 2;
	lblTemp.font=[UIFont fontWithName:@"Verdana" size:14];
	lblTemp.textColor=[UIColor darkGrayColor];
	lblTemp.textAlignment=NSTextAlignmentLeft;
    lblTemp.numberOfLines = 3;
	lblTemp.lineBreakMode = UILineBreakModeWordWrap;
	lblTemp.adjustsFontSizeToFitWidth=YES;
	lblTemp.backgroundColor=[UIColor whiteColor];
	[cell.contentView addSubview:lblTemp];

	
	
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	//cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
	
	return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell = [self getCellContentView:CellIdentifier];
		
	}
	UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
	//UILabel *lblTemp3 = (UILabel *)[cell viewWithTag:3];
	//UILabel *lblTemp4 = (UILabel *)[cell viewWithTag:4];
	UIImageView *picTemp9 = (UIImageView *)[cell viewWithTag:9];
	//UIImageView *picTemp8= (UIImageView *)[cell viewWithTag:8];
	UIImageView *picTemp20= (UIImageView *)[cell viewWithTag:20];
    //	UIImageView *picTemp21= (UIImageView *)[cell viewWithTag:21];
	
    // int indy=indexPath.row*7+1;
    
    //,1,part,/ingimages/1i.jpg,Lemon Lime Soda,7-UP,/viewingred.html?id=1,Lemon Lime Soda,1,part,/ingimages/77i.jpg,Orange juice,,/viewingred.html?id=77,Orange juice,1,part,/ingimages/115i.jpg,Vodka,orange,/viewingred.html?id=115,Vodka,
	picTemp20.image=nil;
    picTemp9.image=nil;
    
    //NSString* pic=[[[myEngine saveGames] objectAtIndex:indexPath.row*3] stringByAppendingString:@".jpg"];
    
    //picTemp20.image=[UIImage imageNamed:pic];
    NSString* title=[[myEngine saveGames] objectAtIndex:indexPath.row*3+0];
    NSString* regd=[[myEngine saveGames] objectAtIndex:indexPath.row*3+1];
    
    
    
    lblTemp1.text=title;
    lblTemp2.text=regd;
    
    
    regd=[regd stringByReplacingOccurrencesOfString:@"," withString:@""];
    regd=[regd stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    
     NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[@"" stringByAppendingFormat:@"Documents/%@.png",regd]];
    
    picTemp20.image=[[UIImage alloc] initWithContentsOfFile:pngPath];
    
	return cell;
}

-(IBAction)captureScreen:(UIView*)myview :(NSString*)regd{
    [self.view viewWithTag:103].hidden=YES;
    [self.view viewWithTag:102].hidden=YES;
    [self.view viewWithTag:24].hidden=YES;
    [self.view viewWithTag:33].hidden=YES;
    
    
    regd=[regd stringByReplacingOccurrencesOfString:@"," withString:@""];
    regd=[regd stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    UIGraphicsBeginImageContext(myview.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //NSLog(@"viewImage %f",viewImage.size.width);
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[@"" stringByAppendingFormat:@"Documents/%@.png",regd]];
    [UIImagePNGRepresentation(viewImage) writeToFile:pngPath atomically:YES];
    //NSLog(@"pngPath %@",pngPath);
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    [self.view viewWithTag:103].hidden=NO;
    [self.view viewWithTag:102].hidden=NO;
    [self.view viewWithTag:24].hidden=NO;
    [self.view viewWithTag:33].hidden=NO;
    
}
-(void)checkText{

    /*
	
	if ([mySearch loadStages]==10){
        mySearch.loadStages=0;
		//swLat,swLon,neLat,neLon
        CLLocation *locSouthWest = [[CLLocation alloc] initWithLatitude:[mySearch swLat] longitude:[mySearch swLon]];
        CLLocation *locNorthEast = [[CLLocation alloc] initWithLatitude:[mySearch neLat] longitude:[mySearch neLon]];
		
        // This is a diag distance (if you wanted tighter you could do NE-NW or NE-SE)
        CLLocationDistance meters = [locSouthWest distanceFromLocation:locNorthEast];
		
        MKCoordinateRegion region;
        region.center.latitude = ([mySearch swLat] + [mySearch neLat]) / 2.0;
        region.center.longitude = ([mySearch swLon] + [mySearch neLon]) / 2.0;
        region.span.latitudeDelta = meters / 111319.5;
        region.span.longitudeDelta = 0.0;
		
        //_savedRegion = [_mapView regionThatFits:region];
		region = [mymapView regionThatFits:region];
        [mymapView setRegion:region animated:YES];
		
        [locSouthWest release];
        [locNorthEast release];
		
		//name.text=[mySearch first];
		//NSLog(@"first %@",[mySearch first]);
		
	}
     */
    // [self.view bringSubviewToFront:mapBar];
    //[mapBar bringSubviewToFront:name];
}
-(void)textFieldDidChange:(id)sel{
    [self checkText];
    
   
    
}
-(void)checkLoad{
   
}
-(void)showLoaded{
    if (selectView==nil){
        selectView=[[UIView alloc] initWithFrame:CGRectMake(50, -400, 400, 400)];
        selectView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:selectView];
    
        [UIView animateWithDuration:0.3f
                              delay: 0.0
                            options: UIViewAnimationCurveLinear
                         animations:^{
                             selectView.frame=CGRectMake(50, 60, 400, 400);
                         }
                         completion:^(BOOL finished){
                         }];

        
        
        
        
    }
    [self.view bringSubviewToFront:selectView];
    
    
    
    for (UIView *anImage in [selectView subviews]) {
        [anImage removeFromSuperview];
    }
    
    
    myscrolly=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,400,400)];
    myscrolly.contentSize=CGSizeMake(400,400);
    myscrolly.backgroundColor=[UIColor whiteColor];
    myscrolly.tag=111;
    [selectView addSubview:myscrolly];
    
    
    
    
}
-(void)goGps:(id)sel{
    int tag=[sel tag];
    NSLog(@"tag %i",tag);
    
    
    
}
-(NSArray *)getBoundingBox:(MKMapRect)mRect{
    CLLocationCoordinate2D bottomLeft = [self getSWCoordinate:mRect];
    CLLocationCoordinate2D topRight = [self getNECoordinate:mRect];
    return @[[NSNumber numberWithDouble:bottomLeft.latitude ],
             [NSNumber numberWithDouble:bottomLeft.longitude],
             [NSNumber numberWithDouble:topRight.latitude],
             [NSNumber numberWithDouble:topRight.longitude]];
}

-(CLLocationCoordinate2D)getCoordinateFromMapRectanglePoint:(double)x y:(double)y{
    MKMapPoint swMapPoint = MKMapPointMake(x, y);
    return MKCoordinateForMapPoint(swMapPoint);
}
-(CLLocationCoordinate2D)getNECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMinX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:MKMapRectGetMaxY(mRect)];
}
-(CLLocationCoordinate2D)getSWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:mRect.origin.x y:MKMapRectGetMaxY(mRect)];
}

-(void)goStars{
    
    CGRect r=[[UIScreen mainScreen] applicationFrame];
    
    
    for (int i=1; i<6; i++) {
        
        UIImageView *star1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"" stringByAppendingFormat:@"Star0%i.png",i]]];
        star1.frame=CGRectMake(r.size.width/2-30,r.size.height/2-30,60,60);
        star1.tag=8;
        star1.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:star1];
        
        
        [UIView animateWithDuration:1.3f animations:^{
            if (i==2){
                star1.transform = CGAffineTransformTranslate(star1.transform, 400, 0);
            } else if (i==1){
                star1.transform = CGAffineTransformTranslate(star1.transform, -100, -400);
            }else if (i==3){
                star1.transform = CGAffineTransformTranslate(star1.transform, 50, 700);
            }else if (i==4){
                star1.transform = CGAffineTransformTranslate(star1.transform, -300, 100);
            }else if (i==5){
                star1.transform = CGAffineTransformTranslate(star1.transform, 400, 400);
            }
            CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.fromValue = [NSNumber numberWithFloat:0.0f];
            animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
            animation.duration = 2.0f;
            animation.repeatCount = 1;
            [star1.layer addAnimation:animation forKey:@"SpinAnimation"];
        }];
        
        
        
        UIImageView *star2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"" stringByAppendingFormat:@"Star0%i.png",i]]];
        star2.frame=CGRectMake(r.size.width/2-30,r.size.height/2-30,60,60);
        star2.tag=8;
        star2.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:star2];
        
        [UIView animateWithDuration:1.2f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{if (i==2){
            star2.transform = CGAffineTransformTranslate(star2.transform, 400, 0);
        } else if (i==1){
            star2.transform = CGAffineTransformTranslate(star2.transform, -100, -400);
        }else if (i==3){
            star2.transform = CGAffineTransformTranslate(star2.transform, 50, 700);
        }else if (i==4){
            star2.transform = CGAffineTransformTranslate(star2.transform, -300, 100);
        }else if (i==5){
            star2.transform = CGAffineTransformTranslate(star2.transform, 400, 300);
        }
                             CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                             animation.fromValue = [NSNumber numberWithFloat:0.0f];
                             animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
                             animation.duration = 3.0f;
                             animation.repeatCount = 1;
                             [star2.layer addAnimation:animation forKey:@"SpinAnimation"];
                         }
                         completion:^(BOOL finished) {
                             
                             
                             if (i==1 && !finish){
                                 //[self goStars];
                             }
                             
                         }];
        
        
        
        
        
        UIImageView *star3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"" stringByAppendingFormat:@"Star0%i.png",i]]];
        star3.frame=CGRectMake(r.size.width/2-30,r.size.height/2-30,60,60);
        star3.tag=8;
        star3.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:star3];
        
        [UIView animateWithDuration:3.0f
                              delay:0.9f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{if (i==2){
            star3.transform = CGAffineTransformTranslate(star3.transform, 400, 0);
        } else if (i==1){
            star3.transform = CGAffineTransformTranslate(star3.transform, -100, -400);
        }else if (i==3){
            star3.transform = CGAffineTransformTranslate(star3.transform, 50, 700);
        }else if (i==4){
            star3.transform = CGAffineTransformTranslate(star3.transform, -300, 100);
        }else if (i==5){
            star3.transform = CGAffineTransformTranslate(star3.transform, 300, 400);
        }
                             CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                             animation.fromValue = [NSNumber numberWithFloat:0.0f];
                             animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
                             animation.duration = 2.5f;
                             animation.repeatCount = 1;
                             [star3.layer addAnimation:animation forKey:@"SpinAnimation"];
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
        
    }
    
    
    // [self.vi bringSubviewToFront:[lastView viewWithTag:4]];
    
    // [self.view bringSubviewToFront:picTemp9];
    
     NSLog(@"finish %i",finish);
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    
    
    
    MKAnnotationView *annotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"park"] ;
    
    NSInteger check=[POI indexOfObject:annotation.title];
   // NSLog(@"wet %@",wet);
    NSString* wetIcon=@"unknown";
    if (check!=NSNotFound ){
        
        
        NSInteger findIt=[captured indexOfObject:annotation.title];
        
        wetIcon=[POI objectAtIndex:check+4];
        
        NSArray* split=[wetIcon componentsSeparatedByString:@","];
        if (split.count>1){
            wetIcon=[split objectAtIndex:0];
        }
        
        
        float offset1=80,offset2=100;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
            offset1=60,offset2=80;
        }
        
        
        UILabel* lblTemp ;/*= [[UILabel alloc] initWithFrame:CGRectMake(-10, offset1, offset2, 13)];
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:10];
        lblTemp.textColor = [UIColor blackColor];
        lblTemp.backgroundColor= [UIColor clearColor];
        lblTemp.shadowColor=[UIColor grayColor];
        lblTemp.textAlignment=NSTextAlignmentCenter;
        lblTemp.adjustsFontSizeToFitWidth=YES;
        lblTemp.text=description;
        [annotationView addSubview:lblTemp];*/
        
        
        lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(0,0, offset2, 15)];
        lblTemp.backgroundColor= [UIColor whiteColor];
        if (findIt!=NSNotFound){
            
            lblTemp.backgroundColor= [UIColor redColor];
        }
        [annotationView addSubview:lblTemp];
        
        
        
        lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(0,0, offset2, 15)];
        lblTemp.font=[UIFont fontWithName:@"Verdana" size:13];
        lblTemp.textColor = [UIColor blackColor];
        lblTemp.backgroundColor= [UIColor clearColor];
       // lblTemp.shadowColor=[UIColor grayColor];
        lblTemp.textAlignment=NSTextAlignmentCenter;
        lblTemp.adjustsFontSizeToFitWidth=YES;
        lblTemp.text=annotation.title;
        [annotationView addSubview:lblTemp];
        
        annotationView.tag=check;
        
        if (findIt!=NSNotFound){
            
            UIImageView *picTemp = [[UIImageView alloc] init];
            picTemp.frame= CGRectMake(0,0,60,60);
            picTemp.tag=20;
            picTemp.contentMode=UIViewContentModeScaleAspectFit;
            picTemp.image=[UIImage imageNamed:@"tickMark"];
            [annotationView addSubview:picTemp];

        }
        
    } else {
       // NSLog(@"fannotation %@",annotation.title);
        failLoad++;
    }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
       // wetIcon=[wetIcon stringByAppendingString:@"60"];
    }
    
    wetIcon=[wetIcon stringByReplacingOccurrencesOfString:@"." withString:@"thth."];
    
    //NSLog(@"wetIcon %@",wetIcon);
    
   // annotationView.tag=[cityList indexOfObject:annotation.title];
    annotationView.image=[UIImage imageNamed:wetIcon];
    if (annotationView.image.size.height==0.0f){
        NSLog(@"wetIcon %@",wetIcon);
    }
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.canShowCallout = YES;
    annotationView.enabled = YES;
    /*
    
   // NSString *pinIdentifier = annotation.identifier; // This is a unique string for each pin and is getting populated every time!
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"park"];
   
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = NO;
    annotationView.enabled = YES;
  //  annotationView.tag = annotation.counter;
    
        annotationView.pinColor = MKPinAnnotationColorRed;
     
     */
    /*
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton addTarget:self action:@selector(mapCalloutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  //  infoButton.tag = annotation.counter;
    annotationView.rightCalloutAccessoryView = infoButton;
    */
    return annotationView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:YES];
    
  //  NSLog(@"didSelectAnnotationView %i",(int)view.tag);
    
    selected=view.tag;
    
    
    if (selected<[POI count]){
        float clat=[[POI objectAtIndex:selected+2] floatValue],clon=[[POI objectAtIndex:selected+1] floatValue];
        
        
        CLLocationCoordinate2D location;
        location.latitude=clat;
        location.longitude=clon;
       // [mymapView setCenterCoordinate:location2 animated:YES];
        
        
        
        MKCoordinateSpan span;
        
        span.latitudeDelta=0.05f;
        span.longitudeDelta=0.05f;
        
       // CLLocationCoordinate2D location;
       // location.latitude=-38.9166667,location.longitude=146.3311393;
        
        MKCoordinateRegion reg;
        reg.center=location;
        reg.span=span;
        
        [mymapView setRegion:reg animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            // do work here
             // infoButt.frame=CGRectMake(width-90,200,90,90);
        });
        
        
        
       // NSLog(@"infoButt %@",infoButt);
        
        /*
        
        [UIView animateWithDuration:0.2f
                              delay: 0.0
                            options: UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^{
                             infoButt.frame=CGRectMake(width-90,200,90,90);
                         }
                         completion:^(BOOL finished){
                             
                         }];*/
        
    }
    
 /*
    if (view.tag<cityList.count){
        
        
        for (UIView *v in [wetInfo subviews]) {
            if (v.tag>10){
                [v removeFromSuperview];
            }
        }
        
        NSString* name=[cityList objectAtIndex:view.tag];
    
        NSArray* deets=[weather getDeets:name];
        
        float clat=[[deets objectAtIndex:1] floatValue],clon=[[deets objectAtIndex:2] floatValue];
        
        
        CLLocationCoordinate2D location2;
        location2.latitude=clat;
        location2.longitude=clon;
        [mymapView setCenterCoordinate:location2 animated:YES];
      //  self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
        
        
        NSLog(@"view %i %@",(int)view.tag,[cityList objectAtIndex:view.tag]);
        
        
        
        
        UILabel* tmpLabel;
        
        NSDictionary* wetdeets=[weather getWeather:name];
        NSDictionary* main=[wetdeets objectForKey:@"main"];
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,2,width-40,22)];
        tmpLabel.tag = 12;
        tmpLabel.text=[name stringByAppendingFormat:@" ,%@",[deets objectAtIndex:4]];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:20];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        float mid=width/3;
        
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
            mid=width/2;
        }
        
        //http://openweathermap.org/current
  
        
        
        float temp=[[main objectForKey:@"temp"] floatValue]-273.15;
       // NSLog(@"t2 %@:%@ %f",name,[main objectForKey:@"temp"],temp);
        float temp_max=[[main objectForKey:@"temp_max"] floatValue]-273.15;
        float temp_min=[[main objectForKey:@"temp_min"] floatValue]-273.15;
        float humidity=[[main objectForKey:@"humidity"] floatValue];
        float pressure=[[main objectForKey:@"pressure"] floatValue];
        
        NSDictionary* weatherD=[[wetdeets objectForKey:@"weather"] objectAtIndex:0];
        NSString* description=[weatherD objectForKey:@"description"];
        
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,22,width-40,18)];
        tmpLabel.tag = 12;
        tmpLabel.text=description;
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        NSString* lowPart=[@"" stringByAppendingFormat:@"%00.1f",temp];
        lowPart=[lowPart substringFromIndex:lowPart.length-2];
        NSString* topPart=[@"" stringByAppendingFormat:@"%1.0f",floor(temp)];
        
        CGRect rect = [lowPart boundingRectWithSize:CGSizeMake(mid-30,30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Verdana" size:30]} context:nil];
        
        
        CGRect brect = [topPart boundingRectWithSize:CGSizeMake(mid-30-rect.size.width,65) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Verdana" size:60]} context:nil];
        
        NSLog(@"rect %f,%f,%f",rect.size.width,brect.size.width,mid);
        
        float offset=20+(mid-rect.size.width-brect.size.width-30)/2;
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset,40,brect.size.width,65)];
        tmpLabel.tag = 12;
        tmpLabel.text=topPart;
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:60];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentRight;
        [wetInfo addSubview:tmpLabel];
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset+brect.size.width,68,rect.size.width,40)];
        tmpLabel.tag = 12;
        tmpLabel.text=lowPart;
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:30];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentRight;
        [wetInfo addSubview:tmpLabel];
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset+brect.size.width+rect.size.width,45,30,24)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"°c"];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:20];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentLeft;
        [wetInfo addSubview:tmpLabel];
        
        
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,100,mid/2,20)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"%1.1f°c",temp_min];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        [wetInfo addSubview:tmpLabel];
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+mid/2,100,mid/2,20)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"%1.1f°c",temp_max];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        
        float moffset=20;
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
            mid=width/4;
            moffset=20+mid;
        }
        
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid,40,mid,16)];
        tmpLabel.tag = 12;
        tmpLabel.text=@"humidity";
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid,56,mid,20)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"%1.0f",humidity];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:18];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid,76,mid,16)];
        tmpLabel.tag = 12;
        tmpLabel.text=@"pressure";
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid,92,mid,20)];
        tmpLabel.tag = 12;
        tmpLabel.text=[@"" stringByAppendingFormat:@"%1.0f",pressure];
        tmpLabel.font=[UIFont fontWithName:@"Verdana" size:18];
        tmpLabel.textColor= [UIColor whiteColor ];
        tmpLabel.adjustsFontSizeToFitWidth=YES;
        tmpLabel.backgroundColor= [UIColor darkGrayColor];
        tmpLabel.textAlignment=NSTextAlignmentCenter;
        [wetInfo addSubview:tmpLabel];
        
        
        
        NSDictionary* wind=[wetdeets objectForKey:@"wind"];
        
        if (wind){
            
            float gust=[[wind objectForKey:@"gust"] floatValue];
            float speed=[[wind objectForKey:@"speed"] floatValue];
            float deg=[[wind objectForKey:@"deg"] floatValue];
  
            
            
            UIImageView *picTemp = [[UIImageView alloc] init];
            picTemp.frame= CGRectMake(moffset+mid*2+(mid-60)/2,10,60,60);
            picTemp.tag=20;
            picTemp.contentMode=UIViewContentModeScaleAspectFit;
            picTemp.image=[UIImage imageNamed:@"whiteArrow"];
            [wetInfo addSubview:picTemp];
            
            //float degrees = 20; //the value in degrees
            picTemp.transform = CGAffineTransformMakeRotation( (deg+180) * M_PI/180);
            
           // picTemp.transform = CGAffineTransformMakeRotation(.34906585);
            
            tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid*2,76,mid,16)];
            tmpLabel.tag = 12;
            tmpLabel.text=@"speed";
            tmpLabel.font=[UIFont fontWithName:@"Verdana" size:14];
            tmpLabel.textColor= [UIColor whiteColor ];
            tmpLabel.adjustsFontSizeToFitWidth=YES;
            tmpLabel.backgroundColor= [UIColor darkGrayColor];
            tmpLabel.textAlignment=NSTextAlignmentCenter;
            [wetInfo addSubview:tmpLabel];
            
            tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(moffset+mid*2,92,mid,20)];
            tmpLabel.tag = 12;
            tmpLabel.text=[@"" stringByAppendingFormat:@"%1.1f",speed];
            tmpLabel.font=[UIFont fontWithName:@"Verdana" size:18];
            tmpLabel.textColor= [UIColor whiteColor ];
            tmpLabel.adjustsFontSizeToFitWidth=YES;
            tmpLabel.backgroundColor= [UIColor darkGrayColor];
            tmpLabel.textAlignment=NSTextAlignmentCenter;
            [wetInfo addSubview:tmpLabel];

        }
        
        
        
        UIButton* setButton=[UIButton buttonWithType:UIButtonTypeCustom];
        setButton.frame=CGRectMake(5, 5,40,40);
        setButton.tag=100;
        setButton.adjustsImageWhenHighlighted=YES;
        [setButton setBackgroundImage:[UIImage imageNamed:@"redCross.png"] forState:UIControlStateNormal];
        [setButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [wetInfo addSubview:setButton];
        
        
        
        [UIView animateWithDuration:0.3f
                              delay: 0.0
                            options: UIViewAnimationCurveLinear
                         animations:^{
                             
                             wetInfo.frame=CGRectMake(0, height-120, width, 120);
                         }
                         completion:^(BOOL finished){
                         }];
    }
  */
}
-(void)goBack{
    
    [UIView animateWithDuration:0.3f
                          delay: 0.5
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         
                         wetInfo.frame=CGRectMake(0, height, width, 120);
                     }
                     completion:^(BOOL finished){
                     }];
    
}
-(void)capture{
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    /*
    imagePickerController = [[UIImagePickerController alloc] init];
    //imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //imagePickerController.allowsImageEditing = YES;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
     */
    /*
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        //imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //imagePickerController.allowsImageEditing = YES;
        imagePickerController.delegate = self;
    } else {
        //imagePickerController.view.hidden = NO;
    }
    */
    

}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    
    // NSLog(@"didFinishPickingImage");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
   // [picker dismissModalViewControllerAnimated:YES];
    picker.view.hidden = YES;
    
    if (imageName.length==0){
        imageName=[@"" stringByAppendingFormat:@"cap%i",(int)capSelected];
    }
    
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.jpg",imageName];
    
    [UIImageJPEGRepresentation(image, 0.6f) writeToFile:jpgPath atomically:YES];
    
    //imageView.image=[UIImage imageWithContentsOfFile:jpgPath];
    [imageView setImage:[UIImage imageWithContentsOfFile:jpgPath] forState:UIControlStateNormal];
    
    NSLog(@"jpgPath %@",jpgPath);
    
    
    NSString*  name=[POI objectAtIndex:capSelected+0];
    [captured addObject:name];
    
    //[myEngine addTimeline:@"" :@"" :jpgPath :[NSDate date]];
    
    [self goBack];
    [self showPOI];
    
  //  [self goStars];
    
}

@end
