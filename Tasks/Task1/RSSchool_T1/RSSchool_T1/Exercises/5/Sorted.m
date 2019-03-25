#import "Sorted.h"

@implementation ResultObject

-(void) dealloc {
    [_detail release];
    _status = nil;
    [super dealloc];
}

@end

@implementation Sorted

-(BOOL)checkSortArray:(NSArray<NSNumber *> *)array {
    [array retain];
    if ([array count] <= 1) {
        [array release];
        return YES;
    }
    
    for(NSUInteger i = 1; i < [array count]; i++) {
        if (array[i].integerValue < array[i - 1].integerValue) {
            [array release];
            return NO;
        }
    }
    [array release];
    return YES;
}

- (void)reverseArraySequence:(NSMutableArray<NSNumber *> *)array startIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex {
    [array retain];
    NSMutableArray *newArray = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < startIndex; i++){
        [newArray addObject: array[i]];
    }
    for (NSUInteger j = endIndex; j > startIndex; j--) {
        [newArray addObject:array[j]];
    }
    for (NSUInteger j = endIndex +1; j < [array count]; j++){
        [newArray addObject:array[j]];
    }
    
    [array removeAllObjects];
    [array addObjectsFromArray:newArray];
    
    [array release];
    [newArray release];
    
}

- (void)swapArrayItems:(NSMutableArray<NSNumber *> *)array firstIndex:(NSUInteger)firstIndex secondIndex:(NSUInteger)secondIndex {
    [array retain];
    NSNumber *tempItem = array[firstIndex];
    array[firstIndex] = array[secondIndex];
    array[secondIndex] = tempItem;
    [array release];
}

- (ResultObject *)sortMethod:(NSMutableArray<NSNumber *> *)array {
    [array retain];
    NSUInteger startIndex = 0;
    NSUInteger endIndex = 0;
    
    for (NSUInteger i = 1; i < [array count]; i++) {
        if (array[i].integerValue < array[i - 1].integerValue) {
            startIndex = i - 1 ;
            
            for (NSUInteger j = [array count] - 1; j > startIndex; j--) {
                if (array[j].integerValue < array[j - 1].integerValue) {
                    endIndex = j;
                    break;
                }
            }
            
            break;
        }
        
    }
    
    BOOL canToSort = YES;
    BOOL isReverseWay = YES;
    
    for (NSUInteger i = startIndex + 1; i <= endIndex; i++) {
        if (array[i].integerValue + 1 != array[i - 1].integerValue) {
            isReverseWay = NO;
        } else if (!isReverseWay && i < endIndex) {
            canToSort = NO;
            break;
        }
    }
    
    ResultObject *resObj = [[ResultObject new] autorelease];
    resObj.status = NO;
    
    if (canToSort) {
        if (isReverseWay) {
            [self reverseArraySequence:array startIndex:startIndex endIndex:endIndex];
            if ([self checkSortArray:array]) {
                resObj.status = YES;
                resObj.detail = [NSString stringWithFormat:@"reverse %lu %lu", startIndex + 1, endIndex + 1];
            }
        } else {
            [self swapArrayItems:array firstIndex:startIndex secondIndex:endIndex];
            if ([self checkSortArray: array]) {
                resObj.status = YES;
                resObj.detail = [NSString stringWithFormat:@"swap %lu %lu", startIndex + 1, endIndex + 1];
            }
        }
    }
    [array release];
    return resObj;
}

// Complete the sorted function below.
-(ResultObject *)sorted:(NSString*)string {
    ResultObject *value = [[ResultObject new] autorelease];
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSMutableArray<NSNumber *> *mainArray = [NSMutableArray arrayWithArray:array];
    
    if([self checkSortArray:mainArray]) {
        value.status = YES;
    } else {
        value = [self sortMethod:mainArray];
    }
    
    return value;
}


@end

