//
//  RSSParser.h
//  HeadLineNews
//
//  Created by p-x9 on 2022/02/13.
//  
//

#import <Foundation/Foundation.h>

@interface RSSParser : NSObject
@property (assign, nonatomic) BOOL shouldShuffle;
- (instancetype)init;
- (void)parseWithURL:(NSURL*)url completionHandler:(void (^)(NSArray* items, NSError* error))completionHandler;
- (NSArray*)parseWithURL:(NSURL*)url;
- (NSArray*)parseWithURLs:(NSArray<NSURL*>*)urls;
@end
