//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOLeftMenuViewController.h"
@interface DEMOLeftMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation DEMOLeftMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, (self.view.frame.size.height - 95*2)) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.rowHeight=64;
        tableView.backgroundColor = [UIColor darkGrayColor];
        tableView.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = YES;
        tableView;
    });
    
    titles = @[@"logs",@"settings",@"help",@"email csv all",@"email PDFs all",@"graphs",
              // @"Home location", @"Work location",
               //@"email pdf all"
               ];
    
    images = @[ @"favs",@"settings",@"i", @"mail", @"mail", @"share",@"mycal",@"mymap",@"mysearch",@"mysearch",@"mysearch"]; //@"mount.png",@"mymap",@"mycal",@"myshop"];
    
    
    //self.view.backgroundColor = [UIColor darkGrayColor];
    self.view.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    
    
    UIView* lgrayView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    lgrayView.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    [self.view addSubview:lgrayView];
    
    UIView* lgrayView2=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-90, self.view.frame.size.width, 90) ];
    lgrayView2.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    [self.view addSubview:lgrayView2];
    
    
    
    flagImage = [[UIImageView alloc] init];
    flagImage.frame= CGRectMake(2,30,60,60);
    flagImage.image=[UIImage imageNamed:@"appicon-76@2x.png"];
    flagImage.contentMode =UIViewContentModeScaleAspectFit;
    flagImage.layer.cornerRadius = 9.0;
    flagImage.layer.masksToBounds = YES;
    flagImage.layer.borderColor = [UIColor whiteColor].CGColor;
    flagImage.layer.borderWidth = 3.0;
    [self.view addSubview:flagImage];
    
    
    mainName = [[UILabel alloc] initWithFrame:CGRectMake(65,30,220,60)];
    mainName.font=[UIFont fontWithName:@"Verdana" size:24];
    mainName.text=@"ATO\nLogBook";
    mainName.numberOfLines = 2;
    mainName.lineBreakMode = NSLineBreakByWordWrapping;
    mainName.textColor = [UIColor whiteColor];
    mainName.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    mainName.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:mainName];

    
    [self.view addSubview:self.tableView];
    
    
    
    
    UIImageView *picTemp1 = [[UIImageView alloc] init];
    picTemp1.frame= CGRectMake(10,self.view.frame.size.height-45,40,40);
    picTemp1.image=[UIImage imageNamed:@"clock.png"];
    picTemp1.contentMode =UIViewContentModeScaleAspectFit;
    picTemp1.tag=14;
    [self.view addSubview:picTemp1];
    
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, self.view.frame.size.height-45+15, 250, 25)];
    dateLabel.font=[UIFont fontWithName:@"Arial" size:20];
    //dateLabel.numberOfLines = 2;
    dateLabel.textAlignment=NSTextAlignmentLeft;
    dateLabel.adjustsFontSizeToFitWidth=YES;
    //dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.backgroundColor= [UIColor clearColor];
    [self.view addSubview:dateLabel];
    
    
    
    dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(55, self.view.frame.size.height-40, 250, 15)];
    dateLabel2.font=[UIFont fontWithName:@"Arial" size:12];
    dateLabel2.adjustsFontSizeToFitWidth=YES;
    dateLabel2.text=@".";
    //dateLabel.numberOfLines = 2;
    //dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    dateLabel2.textAlignment=NSTextAlignmentLeft;
    dateLabel2.textColor = [UIColor lightGrayColor];
    dateLabel2.backgroundColor= [UIColor clearColor];
    [self.view addSubview:dateLabel2];

    
    
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    /*
    
    switch (indexPath.row) {
        case 0:{
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ nearMapViewController alloc] init]] animated:YES];
            ViewController *controller = [[ViewController alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 1:{
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ nearMapViewController alloc] init]] animated:YES];
            settings *controller = [[settings alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 2:
        {
            help *controller = [[help alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 3:
        {
            EmailViewController *controller = [[EmailViewController alloc] init] ;
            controller.type=1;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 4:
        {
            EmailViewController *controller = [[EmailViewController alloc] init] ;
            controller.type=2;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 5:
        {
            EmailViewController *controller = [[EmailViewController alloc] init] ;
            controller.type=3;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        default:
            break;
            
            
    }*/
    /*
    
    

    switch (indexPath.row) {
        case 0:{
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ nearMapViewController alloc] init]] animated:YES];
            ladder *controller = [[ladder alloc] init] ;
            controller.theNum=1;
            controller.menuOn=99;
           // controller.theNum=30;
           // controller.menuOn=99;
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 33:
        {
            ladder *controller = [[ladder alloc] init] ;
            controller.theNum=30;
            controller.menuOn=99;
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 1:
            {
                FindStation *controller = [[FindStation alloc] init] ;
                
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                             animated:YES];
            }
            break;
        case 2:
        {
            BikesViewController *controller = [[BikesViewController alloc] init] ;
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 34:
        {
            ladder *controller = [[ladder alloc] init] ;
            controller.theNum=31;
            controller.menuOn=99;
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 3:
        {
            mustsee *controller = [[mustsee alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 46:
        {
            showEvents *controller = [[showEvents alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 4:
        {
            PicViewController *controller = [[PicViewController alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 5:
        {
            ladder *controller = [[ladder alloc] init] ;
            controller.theNum=2;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        case 6:
        {
            buses *controller = [[buses alloc] init] ;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller ]
                                                         animated:YES];
        }
            break;
        default:
            break;
            
            
    }*/
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [titles count];
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
    
    UILabel *lblTemp;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor=[UIColor darkGrayColor];;
    cell.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    
    lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(42,16,200,32)];
    lblTemp.tag = 1;
    lblTemp.font=[UIFont fontWithName:@"Arial" size:22];
    lblTemp.textColor = [UIColor whiteColor];
    lblTemp.textAlignment=NSTextAlignmentLeft;
    //lblTemp.backgroundColor= [UIColor blackColor];
    lblTemp.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    [cell.contentView addSubview:lblTemp];
    
    UIImageView *picTemp5 = [[UIImageView alloc] init];
    picTemp5.frame= CGRectMake(5,16,32,32);
    picTemp5.tag=5;
    [cell.contentView addSubview:picTemp5];
    
    
    //Initialize Label with tag 1.
    lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(42,16,200,32)];
    lblTemp.font=[UIFont fontWithName:@"Arial" size:18];
    lblTemp.tag = 2;
    lblTemp.textColor = [UIColor whiteColor];
    //lblTemp.numberOfLines = 1;
    //lblTemp.lineBreakMode = NSLineBreakByWordWrapping;
    lblTemp.backgroundColor=[UIColor colorWithRed:69/255.0f green:91/255.0f blue:112/255.0f alpha:1.0f];
    lblTemp.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:lblTemp];
    
    
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        cell = [self getCellContentView:cellIdentifier];
        
    }
    
    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
    UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    
    UIImageView *picTemp = (UIImageView *)[cell viewWithTag:5];
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //cell.backgroundColor = [UIColor clearColor];
        cell.backgroundColor=[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor yellowColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    */
    
    NSString* city=@"";
    NSString* country=[[NSUserDefaults standardUserDefaults] objectForKey:@"myCountry"];
    
    NSRange r1=[country rangeOfString:@"_"];
    if (r1.location!=NSNotFound){
        city=[country substringToIndex:r1.location];
        country=[country substringFromIndex:r1.location+1];
        
    }
    
    
    lblTemp1.text = titles[indexPath.row];
    picTemp.image = [UIImage imageNamed:images[indexPath.row]];
    
    CGSize mTempSize = [lblTemp1.text sizeWithFont:[UIFont fontWithName:@"Arial" size:22]
                     constrainedToSize:CGSizeMake(200, 32)
                         lineBreakMode:NSLineBreakByTruncatingTail ];
    
    
    lblTemp2.frame=CGRectMake(42+mTempSize.width+5,18,200,32);
    lblTemp2.text=nil;
    
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    
    /*
    switch (indexPath.row) {
        case 6:
            //lblTemp2.text=[@"" stringByAppendingFormat:@"(%i)",(int)[[myEngine myEvents] count]/5 ];
            break;
        case 0:
            {
                NSString* str=[NSHomeDirectory() stringByAppendingFormat:@"/Library/%@/%@_mustsee.plist",country,city];
                NSArray* fish = [[NSArray alloc] initWithContentsOfFile:str];
                
                
                lblTemp2.text=[@"" stringByAppendingFormat:@"(%i)",(int)[fish count]/5 ];
            }
            break;
        default:
            break;
    }
    
    
    */
    return cell;
}
-(void)viewDidAppear:(BOOL)animated{
   // NSLog(@"viewDidAppear");
    
    [self upDate];
}
-(void)viewWillAppear:(BOOL)animated{
   // NSLog(@"viewWillAppear");
    
    myEngine=[Engine sharedInstance];
    
   // [self upDate];
}

-(void)upDate{
    
    NSString* country=[[NSUserDefaults standardUserDefaults] objectForKey:@"myCountry"],*city=@"";
    //NSLog(@"upDate country %@ %@",country,myEngine);
    
    NSArray* split=[country componentsSeparatedByString:@"_"];
    if ([split count]==2){
        city=[split objectAtIndex:0];
        //mainName.text=city;//[split objectAtIndex:0];
        //subName.text=[split objectAtIndex:1];
        //flagImage.image=[UIImage imageNamed:[[split objectAtIndex:1] stringByAppendingString:@".png"]];
        
    } else {
       // mainName.text=country;
        
    }
    
    
  //  NSDate* now=[NSDate date];
    
    //NSLog(@"now %@ ",[now description]);
    
  //  NSString* tname=[[NSUserDefaults standardUserDefaults] objectForKey:@"timezone"];
   // NSLog(@"tname %@",tname);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a EEE, d MMM"];
    //NSString* date=[dateFormatter stringFromDate:now];
    /*
    if (tname==nil || [tname length]==0){
        NSString* defaultTimeZone2=[myEngine getTimeZone:country];
       // NSLog(@"defaultTimeZone2 %@",defaultTimeZone2);
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:defaultTimeZone2]];
        dateLabel.text=[dateFormatter stringFromDate:now];
        NSString* name=[myEngine getTimeZoneName:country];
        if (name==nil){
            name=@"Here";
        }
        dateLabel2.text=name;
    } else {
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:tname]];
        dateLabel.text=[dateFormatter stringFromDate:now];
        dateLabel2.text=tname;
    }
    
    
    
    
    NSString* one=[myEngine weatherAt:0];
    //NSLog(@"one %lu %@",(unsigned long)[one length],@"");
    if ((one==nil || [one length]==0)){
        one=[[NSUserDefaults standardUserDefaults] objectForKey:@"oldWeatherData"];
        
        
        //NSLog(@"o1 %i %@",[one length],one);
    }
    */    
}
@end
