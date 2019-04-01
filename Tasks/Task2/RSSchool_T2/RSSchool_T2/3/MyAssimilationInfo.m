//
//  MyAssimilationInfo.m
//  RSSchool_T2
//
//  Created by Tatyana Shut on 31.03.2019.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "MyAssimilationInfo.h"


@interface MyAssimilationInfo ()

@property (nonatomic, assign) NSInteger years;
@property (nonatomic, assign) NSInteger months;
@property (nonatomic, assign) NSInteger weeks;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

@end

@implementation MyAssimilationInfo

+ (instancetype)assimilationInfoFromString:(NSString*)dateString
{
    NSString* startDate =@"14 August 2208 03:13:37";
    [startDate retain];
    MyAssimilationInfo* date = [[[MyAssimilationInfo alloc] init] autorelease];
    NSDateFormatter* badFormater = [[NSDateFormatter alloc] init];
    NSDateFormatter* normFormater = [[NSDateFormatter alloc] init];
    
    
    badFormater.dateFormat = @"yyyy:MM:dd@ss\\mm/HH";
    normFormater.dateFormat = @"dd MMMM yyyy HH:mm:ss";
    
    
    NSDate* assimilationDate = [normFormater dateFromString:startDate];
    [assimilationDate retain];
    [normFormater release];
    [startDate release];
    NSDate* dateConvert = [badFormater dateFromString:dateString];
    [badFormater release];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    
    
    NSDateComponents* components = [calendar components:(kCFCalendarUnitYear |
                                                         kCFCalendarUnitMonth |
                                                         kCFCalendarUnitDay |
                                                         kCFCalendarUnitHour |
                                                         kCFCalendarUnitMinute |
                                                         kCFCalendarUnitSecond)
                                               fromDate:dateConvert
                                                 toDate:assimilationDate
                                                options:NSCalendarWrapComponents];
    [assimilationDate release];
    
    date.years = components.year;
    date.months = components.month;
    date.days = components.day;
    date.hours = components.hour;
    date.minutes = components.minute;
    date.seconds = components.second;
    
    
    
    
    return date;
}
@end
