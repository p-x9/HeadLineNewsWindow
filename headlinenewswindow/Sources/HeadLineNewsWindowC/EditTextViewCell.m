#import "include/EditTextViewCell.h"
// FIXME
#define PREF_PATH @"/var/mobile/Library/Preferences/com.p-x9.headlinenewswindow.pref.plist"

@interface EditTextViewCell()
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *defaults;
@property (nonatomic, retain) NSString *defaultValue;
@property (nonatomic, retain) NSString *postNotification;
//@property (nonatomic, getter=prefPath) NSString *prefPath;
@end

@implementation EditTextViewCell

- (UITextView*)textView {
    if(!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize: 14];
    }
    return _textView;
}

- (UILabel*)placeholderLabel {
    if(!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeholderLabel.textColor = UIColor.placeholderTextColor;
        _placeholderLabel.font = [UIFont systemFontOfSize: 14];
        _placeholderLabel.numberOfLines = 0;
    }
    return _placeholderLabel;
}

- (NSString *)prefPath {
    // FIXME
    return PREF_PATH;//[[@"/var/mobile/Library/Preferences/" stringByAppendingString:self.defaults] stringByAppendingString: @".plist"];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    
    if(self) {
        [self readPref];
        [self setupViews];
        [self setupViewConstraints];
    }

    return self;
}

- (id)initWithSpecifier:(PSSpecifier *)specifier {
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
    
    if(self) {
        [self readPref];
        [self setupViews];
        [self setupViewConstraints];
    }

     return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
     [super refreshCellContentsWithSpecifier: specifier];
     [self readPref];
}

-(void)readPref {
    self.key = [self.specifier.properties[@"key"] stringValue];
    self.defaultValue = [self.specifier.properties[@"default"] stringValue];
    self.defaults = [self.specifier.properties[@"defaults"] stringValue];
    self.postNotification = [self.specifier.properties[@"PostNotification"] stringValue];
    NSString *placeholder = [self.specifier.properties[@"placeholder"] stringValue];

    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:[self prefPath]]?:[NSMutableDictionary dictionary];
    self.textView.text = prefs[self.key] ?: self.defaultValue;
    self.placeholderLabel.text = placeholder;

    [self updatePlaceholderVisibility];
}

-(void)setupViews {
    [self.contentView addSubview: self.textView];
    [self.contentView addSubview: self.placeholderLabel];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleDoneButton)];
    UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 44)];
    toolbar.items = @[spacerItem, doneButton];
    
    self.textView.inputAccessoryView = toolbar;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
    return 250;
}

- (void)setupViewConstraints {
    self.textView.translatesAutoresizingMaskIntoConstraints = false;
    self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;

    [NSLayoutConstraint activateConstraints:@[
        [self.textView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant: 8],
        [self.textView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant: 0],
        [self.textView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant: 0],
        [self.textView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -8],
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.placeholderLabel.topAnchor constraintEqualToAnchor:self.textView.topAnchor constant: 6],
        [self.placeholderLabel.leftAnchor constraintEqualToAnchor:self.textView.leftAnchor constant: 6],
        [self.placeholderLabel.rightAnchor constraintEqualToAnchor:self.textView.rightAnchor constant: -6],
        [self.placeholderLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.textView.bottomAnchor constant: -6],
    ]];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:self.prefPath] ?: [NSMutableDictionary dictionary];
    [prefs setObject:textView.text forKey:self.key];
    [prefs writeToFile:self.prefPath atomically:YES];

     CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)(self.postNotification), NULL, NULL, YES);

     [self updatePlaceholderVisibility];
}

-(void)updatePlaceholderVisibility {
    if(self.textView.text.length == 0) {
         self.placeholderLabel.hidden = false;
     } else {
         self.placeholderLabel.hidden = true;
     }
}

-(void)handleDoneButton {
    [self.textView resignFirstResponder];
}

@end
