@import UIKit;
#import "sparkcolorheaders/SparkColourPickerUtils.h"
#import "HeadLineNewsView.h"
#import "Item.h"
#import "RSSParser.h"

@interface SpringBoard : UIApplication
@property (nonatomic) UIWindow *newsWindow;
@property (nonatomic) HeadLineNewsView* headlineNewsView;
@property (nonatomic) RSSParser* parser;
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
//new
- (void)setupNewsWindow;
@end
