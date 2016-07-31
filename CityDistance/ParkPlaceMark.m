#import "ParkPlaceMark.h"

@implementation ParkPlaceMark
@synthesize coordinate;

- (NSString *)subtitle{
	return MYsubtitle;
}
- (NSString *)title{
	return MYtitle;
}
-(void)setSubTitle:(NSString*)tit{
	MYsubtitle=tit;
	
}
-(void)setTitle:(NSString*)tit{
	MYtitle=tit ;
	
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	MYsubtitle=@"" ;
	MYtitle=@"" ;
	
	return self;
}
@end