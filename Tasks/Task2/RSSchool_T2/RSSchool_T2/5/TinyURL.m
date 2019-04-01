#import "TinyURL.h"

#import "TinyURL.h"

@interface TinyURL ()

@property (nonatomic, retain )NSMutableDictionary *item;

@end

@implementation TinyURL

- (instancetype)init
{
    self = [super init];
    if (self) {
        _item = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSURL *)encode:(NSURL *)originalURL{
    
    [originalURL retain];
    
    NSString *urlstr = originalURL.absoluteString;
    [urlstr retain];
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    [alphabet retain];
    NSMutableString *stringResult = [NSMutableString new];
    
    [stringResult appendString:@"https://tinyURL.com/"];
    for (NSUInteger i = 0; i < 8; i++) {
        u_int32_t randomString = arc4random() % [alphabet length];
        unichar charString = [alphabet characterAtIndex:randomString];
        [stringResult appendFormat:@"%C", charString];
        
    }
    NSURL *url = [NSURL URLWithString: stringResult];
    [_item setObject:originalURL forKey:url];
    [stringResult release];
    return url;
}

- (NSURL *)decode:(NSURL *)shortenedURL{
    
    [shortenedURL retain];
    NSURL *decodeURL = [_item objectForKey:shortenedURL];
    [shortenedURL release];
    return decodeURL;
}

- (void)dealloc
{
    [_item release];
    [super dealloc];
}

@end




