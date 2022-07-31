//
//  NSMutableArray.m
//  HeadLineNews
//
//  Created by p-x9 on 2022/03/21.
//  
//

#import <Foundation/Foundation.h>

@implementation NSMutableArray (Shuffle)
- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--)
        [self exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
}
- (NSMutableArray *)shuffled {
    NSMutableArray *tmp = [self mutableCopy];
    [tmp shuffle];
    return tmp;
}
@end
