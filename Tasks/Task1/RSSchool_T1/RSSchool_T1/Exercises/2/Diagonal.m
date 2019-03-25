#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    [array retain];
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    int mainDiagonal = 0;
    int sideDiagonal = 0;
    int difference = 0;
    
    for (NSUInteger i = 0; i < [array count]; i++) {
        NSString * rowString = [array objectAtIndex:i];
        [newArray addObject:[[NSArray alloc] initWithArray:[rowString componentsSeparatedByString:@" "]]];
        
    }
    for (NSUInteger i = 0; i < [array count]; i++) {
        mainDiagonal += [(NSNumber *)newArray[i][i] intValue];
        sideDiagonal += [(NSNumber *)newArray[[array count]-i-1][i] intValue];
    }
    
    difference = abs(mainDiagonal - sideDiagonal);
    [newArray release];
    [array release];
    return  [NSNumber numberWithInteger:difference];
}
@end
