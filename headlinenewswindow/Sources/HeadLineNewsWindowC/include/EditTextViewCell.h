#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface EditTextViewCell : PSTableCell<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@end