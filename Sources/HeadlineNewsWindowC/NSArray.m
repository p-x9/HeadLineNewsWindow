//
//  NSArray.m
//  HeadLineNews
//
//  Created by p-x9 on 2022/03/21.
//  
//

#import <Foundation/Foundation.h>
#import "NSMutableArray.h"

@implementation NSArray (Shuffle)
- (NSArray *)shuffled {
    NSMutableArray *shuffled = [[[NSMutableArray alloc] initWithArray:self] shuffled];
    return (NSArray*)shuffled;
}
@end
