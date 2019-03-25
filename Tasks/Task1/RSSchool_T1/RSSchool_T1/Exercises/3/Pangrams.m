#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    [string retain];
    
    NSString *stringWithoutSpaces = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    [string release];
    [stringWithoutSpaces retain];
    NSString *mainString = [stringWithoutSpaces lowercaseString];
    [mainString retain];
    [stringWithoutSpaces release];
    NSMutableSet *set = [NSMutableSet new];
    
    for (NSUInteger i = 0; i < [mainString length]; i++) {
        [set addObject:[NSString stringWithFormat:@"%c", [mainString characterAtIndex:i]]];
    }
    [mainString release];
    
    if( [set count] == 26) { // where 26 - number of letters in the English alphabet
        [set release];
        return YES;
    }else{
        [set release];
        return NO;
    }
}

@end
