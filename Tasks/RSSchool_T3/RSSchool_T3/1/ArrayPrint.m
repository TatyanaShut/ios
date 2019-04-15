#import "ArrayPrint.h"


NSInteger classDefinition(id object) {
    if ([object isKindOfClass:[NSArray class]]){
        return 1;
    } else if ([object isKindOfClass:[NSNull class]]) {
        return 2;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return 3;
    } else if ([object isKindOfClass:[NSString class]]) {
        return 4;
    }
    return 0;
}

NSString *stringFormation(id object) {
    NSMutableString *result = [[NSMutableString alloc] init];
    switch (classDefinition(object)) {
        case 1:
            [result appendString:@"["];
            for (id i in object) {
                [result appendString: stringFormation(i)];
            }
            [result appendString:@"],"];
            
            break;
        case 2:
            [result appendString: @"null,"];
            break;
        case 3:
            [result appendFormat:@"%@,", object];
            break;
        case 4:
            [result appendFormat:@"\"%@\",", object];
            break;
        default:
            [result appendString:@"unsupported,"];
            break;
    }
    
    [result autorelease];
    return result;
}

@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    [resultString appendString:@"["];
    NSArray *array = self;
    
    for (int i = 0; i < [array count]; i++) {
        [resultString appendString: stringFormation(array[i])];
    }
    
    [resultString appendString:@"]"];
    [resultString replaceOccurrencesOfString:@",]" withString:@"]" options:1 range: NSMakeRange(0, [resultString length])];
    
    [resultString autorelease];
    return resultString;
}

@end
