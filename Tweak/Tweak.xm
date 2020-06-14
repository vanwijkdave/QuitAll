#import "Tweak.h"

bool enabled = true;
bool leftButtonPlacement = false;
bool darkStyle = false;
bool dontQuitNowPlaying = true;
bool dontQuitNavigation = true;

bool addedButton = false;
bool transparentButton = false;
bool notchlessInstalled = false;
UIView *buttonView;
UILabel *fromLabel;

%hook SBSwitcherAppSuggestionContentView
- (void)didMoveToWindow {
    %orig;
    if (!addedButton) {
        //create base view
        buttonView = [[UIView alloc] init];
        buttonView.frame = CGRectMake(300.0, 12.0, 60.0, 26.0);
        buttonView.clipsToBounds = true;
        buttonView.tag = 7;
        buttonView.alpha = 0.60;
        buttonView.layer.cornerRadius = 12;

        //create smooth smooth blur
        UIBlurEffect *blurEffect;
        if (darkStyle) {
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        } else {
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        }
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = buttonView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [buttonView addSubview:blurEffectView];

        //add subview to main view
        [self insertSubview:buttonView atIndex:10];

        // View constraints
        buttonView.translatesAutoresizingMaskIntoConstraints = false;
        if(notchlessInstalled) {
            [buttonView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:35].active = YES;
        } else {
            [buttonView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:12].active = YES;
        }
        if (leftButtonPlacement) {
            [buttonView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15].active = YES;
        } else {
            [buttonView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-18].active = YES;
        }
        [buttonView.widthAnchor constraintEqualToConstant:57.0].active = YES;
        [buttonView.heightAnchor constraintEqualToConstant:25.0].active = YES;

        //create a button for inside the view
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                action:@selector(buttonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
        button.frame = buttonView.frame;
        [buttonView addSubview:button];
        [self insertSubview:button atIndex:12];

        //button constraints
        button.translatesAutoresizingMaskIntoConstraints = false;
        [button.topAnchor constraintEqualToAnchor:buttonView.topAnchor constant:0].active = YES;
        [button.bottomAnchor constraintEqualToAnchor:buttonView.bottomAnchor constant:0].active = YES;
        [button.leftAnchor constraintEqualToAnchor:buttonView.leftAnchor constant:0].active = YES;
        [button.rightAnchor constraintEqualToAnchor:buttonView.rightAnchor constant:0].active = YES;


        //add label to button
        UIFont *customFont = [UIFont fontWithName:@"Arial-BoldMT" size:12.5]; //custom font
        fromLabel = [[UILabel alloc]initWithFrame:buttonView.bounds];
        fromLabel.text = @"Clear";
        fromLabel.font = customFont;
        fromLabel.textAlignment = NSTextAlignmentCenter;
        fromLabel.tag = 7;
        fromLabel.textColor = [UIColor whiteColor];

        [self insertSubview:fromLabel atIndex:11];

        //label constraints
        fromLabel.translatesAutoresizingMaskIntoConstraints = false;
        [fromLabel.topAnchor constraintEqualToAnchor:buttonView.topAnchor constant:0].active = YES;
        [fromLabel.bottomAnchor constraintEqualToAnchor:buttonView.bottomAnchor constant:0].active = YES;
        [fromLabel.leftAnchor constraintEqualToAnchor:buttonView.leftAnchor constant:0].active = YES;
        [fromLabel.rightAnchor constraintEqualToAnchor:buttonView.rightAnchor constant:0].active = YES;

        fromLabel.alpha = 0;
        buttonView.alpha = 0;

        [UIView animateWithDuration:0.5 animations:^ {
            buttonView.alpha = 1;
            fromLabel.alpha = 1;
        } completion:^(BOOL finished) {}];
        addedButton = true;
    } else if (addedButton && transparentButton) {
        [UIView animateWithDuration:0.3 animations:^ {
            buttonView.alpha = 0.6;
            fromLabel.alpha = 1;
        }];

        transparentButton = false;
    }

}


%new
- (void)buttonClicked:(UIButton*)sender {
    SBMainSwitcherViewController *mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
    NSArray *items = mainSwitcher.recentAppLayouts;
    for(SBAppLayout *item in items) {
        SBDisplayItem *displayItem = [item.rolesToLayoutItemsMap objectForKey:@1];
        NSString *bundleID = displayItem.bundleIdentifier;
        NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];

        if (dontQuitNowPlaying && dontQuitNavigation) {
            if (![bundleID isEqualToString: nowPlayingID] && ![bundleID isEqualToString:@"com.google.Maps"] && ![bundleID isEqualToString:@"com.apple.Maps"] && ![bundleID isEqualToString:@"com.waze.iphone"]) {
                [mainSwitcher _deleteAppLayout:item forReason: 1];
            }
        } else if (!dontQuitNowPlaying && dontQuitNavigation) {
            if (![bundleID isEqualToString:@"com.google.Maps"] || ![bundleID isEqualToString:@"com.apple.Maps"] || ![bundleID isEqualToString:@"com.waze.iphone"]) {
                [mainSwitcher _deleteAppLayout:item forReason: 1];
            }
        } else if (dontQuitNowPlaying && !dontQuitNavigation) {
            if (![bundleID isEqualToString: nowPlayingID] ) {
                [mainSwitcher _deleteAppLayout:item forReason: 1];
            }
        } else {
            [mainSwitcher _deleteAppLayout:item forReason: 1];
        }
    }

    [UIView animateWithDuration:0.3 animations:^ {
        buttonView.alpha = 0;
        fromLabel.alpha = 0;
    }];
    transparentButton = true;
}
%end

%hook SBMainSwitcherViewController
// hide the button when going back to the springboard in a smooth way
- (void)switcherContentController:(id)arg1 setContainerStatusBarHidden:(BOOL)arg2 animationDuration:(double)arg3 {
    if (arg2 == false) {
            [UIView animateWithDuration:0.3 animations:^ {
                buttonView.alpha = 0;
                fromLabel.alpha = 0;

            }];
        transparentButton = true;

    }
    %orig;

}
%end

void loadPrefs() {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.daveapps.quitallprefs"];

    enabled = [([prefs objectForKey:@"kEnabled"] ?: @(YES)) boolValue];
    darkStyle = [([prefs objectForKey:@"kDarkButton"] ?: @(NO)) boolValue];
    leftButtonPlacement = [([prefs objectForKey:@"kLeftPlacement"] ?: @(NO)) boolValue];
    dontQuitNowPlaying = [([prefs objectForKey:@"kKeepMusicAlive"] ?: @(YES)) boolValue];
    dontQuitNavigation = [([prefs objectForKey:@"kKeepNavAlive"] ?: @(YES)) boolValue];
}

%ctor {
    loadPrefs();

    notchlessInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/zNotchless.dylib"];
    if (enabled) {
        %init;
    }
}
