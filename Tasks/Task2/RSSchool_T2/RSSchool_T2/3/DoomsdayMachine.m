#import "DoomsdayMachine.h"
#import "MyAssimilationInfo.h"

@implementation DoomsdayMachine

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString{
    
    return [[MyAssimilationInfo assimilationInfoFromString:dateString] autorelease];
}
- (NSString *)doomsdayString{
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    NSString* startDate =@"14 August 2208 03:13:37";
    [startDate retain];
    
    format.dateFormat = @"dd MMMM yyyy HH:mm:ss";
    NSDate* assimDate = [format dateFromString:startDate];
    [assimDate retain];
    [format release];
    NSDateFormatter* humanFormater = [[NSDateFormatter alloc] init];
    humanFormater.dateFormat = @"EEEE, MMMM dd, yyyy";
    NSString* result = [humanFormater stringFromDate:assimDate];
    
    [assimDate release];
    [humanFormater release];
    
    return result;
    
}

@end
