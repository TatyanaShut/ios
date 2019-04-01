#import "RomanTranslator.h"

@implementation RomanTranslator
- (NSString *)romanFromArabic:(NSString *)arabicString{
    [arabicString retain];
    NSMutableString* result = [[NSMutableString new] autorelease];
    
    [self translating:[arabicString integerValue] withKey:@"1000" withInOutResultingString:result];
    [arabicString release];
    return result;
    
}
- (void)addToStr:(NSMutableString*) string chrt:(char) chr bout:(NSInteger) n{
    [string retain];
    for(NSInteger i = 0; i < n; i++){
        [string appendFormat:@"%c", chr];
    }
    [string release];
}

-(void) translating:(NSInteger) arrabNumber withKey:(NSString*) key withInOutResultingString:(NSMutableString*) string {
    [key retain];
    [string retain];
    
    NSDictionary* mainDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:  @'I', @"1", @'V', @"5", @'X', @"10",
                                    @'L', @"50", @'C', @"100", @'D', @"500",
                                    @'M', @"1000", nil];
    
    NSArray* sortedArray = [[mainDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]){
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
            
        }
    }];
    
    NSUInteger index = [sortedArray indexOfObject:key];
    
    NSInteger number = arrabNumber / [key integerValue];
    
    NSInteger newValue = arrabNumber % [key integerValue];
    
    
    switch (number) {
        case 4:
            [self addToStr:string chrt:[[mainDictionary objectForKey:key] charValue] bout:1];
            [self addToStr:string chrt:[[mainDictionary objectForKey:sortedArray[index - 1]] charValue] bout:1];
            break;
        case 9:
            [self addToStr:string chrt:[[mainDictionary objectForKey:key] charValue] bout:1];
            [self addToStr:string chrt:[[mainDictionary objectForKey:sortedArray[index - 2]] charValue] bout:1];
            break;
        case 5:
            [self addToStr:string chrt:[[mainDictionary objectForKey:sortedArray[index - 1]] charValue] bout:1];
            break;
            
        default:
            if (number < 4)
            {
                [self addToStr:string chrt:[[mainDictionary objectForKey:key] charValue] bout:number];
            }
            else
            {
                [self addToStr:string chrt:[[mainDictionary objectForKey:sortedArray[index - 1]] charValue] bout:1];
                [self addToStr:string chrt:[[mainDictionary objectForKey:key] charValue] bout:(number - 5)];
            }
            break;
    }
    [mainDictionary release];
    
    if ( (index + 2) < [sortedArray count]){
        [self translating:newValue withKey:sortedArray[index + 2] withInOutResultingString:string];
    }
    
}

- (NSString *)arabicFromRoman:(NSString *)romanString{
    [romanString retain];
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"I", @"5", @"V", @"10", @"X",
                          @"50",@"L", @"100", @"C", @"500", @"D",
                          @"1000",@"M", nil];
    NSInteger result = 0;
    NSMutableArray* romanComponents = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [romanString length]; i++) {
        [romanComponents addObject:[romanString substringWithRange:NSMakeRange(i, 1)]];
    }
    [romanString release];
    
    
    
    for (NSInteger i = 0; i < [romanComponents count]; i++)
    {
        if (i + 1 < [romanComponents count])
        {
            NSInteger value = [[dict valueForKey:[romanComponents objectAtIndex:i]] integerValue];
            NSInteger nextValue = [[dict valueForKey:[romanComponents objectAtIndex:i + 1]] integerValue];
            
            if (nextValue <= value)
            {
                result += value;
            } else
            {
                result -= value;
            }
        }
        else
        {
            NSInteger testValue = [[dict valueForKey:[romanComponents objectAtIndex:i]] integerValue];
            result += testValue;
        }
    }
    
    NSString* mainResult = [[[NSString alloc] initWithFormat:@"%ld", result] autorelease];
    
    [romanComponents release];
    [dict release];
    
    return mainResult;
}

@end
