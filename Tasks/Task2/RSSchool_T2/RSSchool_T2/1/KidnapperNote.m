#import "KidnapperNote.h"

@implementation KidnapperNote
- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note{
    [magaine retain];
    [note retain];
    
    NSString *lowercaseStringMagazine  = [magaine lowercaseString];
    NSString* lowercaseStringNote = [note lowercaseString];
    
    [magaine release];
    [note release];
    
    NSArray *wordsMagazine = [lowercaseStringMagazine componentsSeparatedByString: @" "];
    
    NSArray *wordsNote = [lowercaseStringNote componentsSeparatedByString: @" "];
    
    NSMutableArray *mutableWordsMagazine = [NSMutableArray arrayWithCapacity:[wordsMagazine count]];
    [mutableWordsMagazine addObjectsFromArray:wordsMagazine];
    
    NSMutableArray *mutableWordsNote = [NSMutableArray arrayWithCapacity:[wordsMagazine count]];
    [mutableWordsNote addObjectsFromArray:wordsNote];
    
    NSMutableSet *resultNote = [NSMutableSet new];
    [resultNote retain];
    
    
    for(NSInteger i = 0; i < [mutableWordsMagazine count]; i++){
        for(NSInteger j = 0; j < [mutableWordsNote count]; j++){
            
            if(mutableWordsMagazine[i] == mutableWordsNote[j] ){
                
                [resultNote addObject:mutableWordsMagazine[i]];
            }
        }
    }
    if([mutableWordsNote count] == [resultNote count]){
        
        [resultNote release];
        return YES;
    }
    else {
        [resultNote release];
        return NO;
    }
    
}
@end
