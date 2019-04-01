//
//  MyAssimilationInfo.h
//  RSSchool_T2
//
//  Created by Tatyana Shut on 31.03.2019.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoomsdayMachine.h"

@interface MyAssimilationInfo : NSObject <AssimilationInfo>

@property (nonatomic, readonly) NSInteger years;
@property (nonatomic, readonly) NSInteger months;
@property (nonatomic, readonly) NSInteger weeks;
@property (nonatomic, readonly) NSInteger days;
@property (nonatomic, readonly) NSInteger hours;
@property (nonatomic, readonly) NSInteger minutes;
@property (nonatomic, readonly) NSInteger seconds;

+ (instancetype)assimilationInfoFromString:(NSString*)dateString;

@end

