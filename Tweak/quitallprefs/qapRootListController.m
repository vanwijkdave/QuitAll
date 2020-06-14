#include "qapRootListController.h"

@implementation qapRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:0.76 green:0.23 blue:0.29 alpha:1.0];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}

- (void)twitterDave {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/davewijk"] options:@{} completionHandler:nil];
}

- (void)SourceCode {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/vanwijkdave/QuitAll"] options:@{} completionHandler:nil];
}

- (void)donateDave {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/vanwijkdave"] options:@{} completionHandler:nil];
}

@end
