#import "FullBinaryTrees.h"

//не оформляла MRC  хотела придумать что-то красивое, но что-то не получилось, вот мои наброски


@interface TreeNode : NSObject

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong, nullable) TreeNode *left;
@property (nonatomic, strong, nullable) TreeNode *right;


+ (instancetype)initWithValue:(NSNumber *)value;

@end

@implementation TreeNode

+ (instancetype)initWithValue:(NSNumber *)value
{
    return [[self alloc] initWithValue:value];
}

- (instancetype)initWithValue:(NSNumber *)value
{
    if (self = [super init]) {
        _value = value;
    }
    
    return self;
}

- (TreeNode *)clone
{
    TreeNode *node = [TreeNode initWithValue:self.value];
    if (self.left != nil) node.left = [self.left clone];
    if (self.right != nil) node.right = [self.right clone];
    
    return node;
}

@end


@interface FullBinaryTrees ()

@property (nonatomic, strong) NSMutableDictionary *map;

@property (nonatomic, strong) NSMutableString *string;

@property (nonatomic) NSUInteger counter;

@end

@implementation FullBinaryTrees

- (instancetype)init
{
    self = [super init];
    if (self) {
        _map = [NSMutableDictionary dictionary];
        _string = [NSMutableString string];
    }
    return self;
}

- (NSString *)stringForNodeCount:(NSInteger)count
{
    [self allPosible:count];
    
    NSArray *result = self.map[@(count)];
    
    for (NSUInteger i=0; i<result.count; i++) {
        
        [self.string appendString:@"["];
        self.counter = 0;
        [self collectNode:result[i] position:0 count:count];
        
        [self.string appendString:@"]"];
        NSLog(@"%@", _string);
    }
    NSLog(@"%@", _string);
    return [NSString stringWithFormat:@"[%@]", self.string];
}

- (NSArray *)allPosible:(NSUInteger)count
{
    NSMutableArray *temp = [NSMutableArray array];
    
    if (count == 1) {
        [temp addObject:[[TreeNode alloc] initWithValue:@0]];
    } else {
        for (NSUInteger x = 0; x < count; x++) {
            NSUInteger y = count - 1 - x;
            for (TreeNode *left in [self allPosible:x]) {
                for (TreeNode *right in [self allPosible:y]) {
                    TreeNode *node = [[TreeNode alloc] initWithValue:@0];
                    node.left = left;
                    node.right = right;
                    [temp addObject:node];
                }
            }
        }
    }
    
    [self.map setObject:temp forKey:@(count)];
    
    return [self.map objectForKey:@(count)];
}



- (void)collectNode:(TreeNode *)node position:(NSUInteger)position count:(NSUInteger)count
{
    
    if (node != nil) {
        
        [self.string appendString:@","];
        [self.string appendString:node.value.stringValue];
        self.counter += 1;
        
        [self collectNode:node.left position:position + 1 count:count];
        [self collectNode:node.right position:position + 1 count:count];
        
        if (self.counter == count) return;
        
        if (node.left == nil) {
            [self.string appendString:@","];
            [self.string appendString:@"null"];
        }
        
        if (node.right == nil) {
            [self.string appendString:@","];
            [self.string appendString:@"null"];
        }
    }
}

@end
