#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    [array retain];
    NSInteger sum = 0;
    for(NSNumber *number in array){
        sum+=number.integerValue;
    }
    [array release];
    return [NSNumber numberWithInteger:sum];
}
@end
