#import "MatrixHacker.h"
@interface Character : NSObject <Character>
@property (nonatomic, assign, getter=isClone) BOOL clone;
@property (nonatomic, copy) NSString *name;
@end

@implementation Character

+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone {
    return [[[self class] alloc] initWithName:name isClone:clone];
}

- (BOOL)isClone {
    return _clone;
}

- (NSString *)name {
    return _name;
}

- (NSString *)shearchNeo {
    
    if ([_name isEqualToString:@"Neo"])
    {
        _clone = NO;
    }
    else
    {
        _clone = YES;
    }
    
    
    return [[[NSString alloc] initWithFormat:@"name:%@ isClone:%@", _name, _clone] autorelease];
}
- (void)dealloc {
    [_name release];
    [super dealloc];
}
@end
@interface MatrixHacker()
@property (copy) id<Character> (^neoName)(NSString* name);
@end

@implementation MatrixHacker

-(void)injectCode:(id<Character> (^)(NSString *))theBlock
{
    self.neoName = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names
{
    NSMutableArray* mainArray = [[[NSMutableArray alloc] init] autorelease];
    for (NSString* name in names)
    {
        if(_neoName)
        {
            id<Character> character = _neoName(name);
            [mainArray addObject:character];
        }
    }
    return mainArray;
}

- (void)dealloc
{
    [_neoName release];
    [super dealloc];
}

@end
