#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    [string retain];
    NSString *stringWithoutSpaces = [[string componentsSeparatedByString:@" "] componentsJoinedByString:@""];
    [stringWithoutSpaces retain];
    float l = sqrt([stringWithoutSpaces length]);
    NSInteger rows = (int)floor(l);
    NSInteger columns = (int)ceil(l);
    NSInteger coefficient = 0;
    
    if (rows *columns < [stringWithoutSpaces length]) {
        if(rows < columns){
            rows++;
        }
        else{
            columns++;
        }
    }
    NSMutableArray *grid = [[NSMutableArray alloc] initWithCapacity:rows];
    
    for (NSInteger i = 0; i < rows - 1; i++) {
        [grid addObject:[string substringWithRange:NSMakeRange(coefficient, columns)]];
        coefficient += columns;
    }
    [grid addObject:[string substringFromIndex:coefficient]];
    
    NSMutableString *result = [[NSMutableString new] autorelease];
    
    for (NSUInteger i = 0; i < columns; i++) {
        for (NSUInteger j = 0; j < rows; j++) {
            NSString *newRow = grid[j];
            
            
            if ([newRow length] > i) {
                [result appendString:[NSString stringWithFormat:@"%c", [newRow characterAtIndex:i]]];
            }
        }
        if (i != columns - 1){
            [result appendString:@" "];
        }
    }
    [grid release];
    [stringWithoutSpaces release];
    [string release];
    return result;
}
@end
