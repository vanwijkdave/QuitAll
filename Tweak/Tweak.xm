//import shit
#import <Cephei/HBPreferences.h>


//settings
bool enabled = true;
bool leftButtonPlacement = false;
int darkStyle = 0;
bool dontQuitNowPlaying = true;
bool dontQuitNavigation = true;
//variable shit
bool addedButton = false;
bool transparantButton = false;
UIView *buttonView;
UILabel *fromLabel;

@interface SBSwitcherAppSuggestionContentView: UIView
@end

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;               //@synthesize bundleIdentifier=_bundleIdentifier - In the implementation block
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;                                                                                     //@synthesize bundleIdentifier=_bundleIdentifier - In the implementation block
@end

@interface SBMediaController : NSObject
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
+(id)sharedInstance;
@end



//interfaces
@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
-(id)recentAppLayouts;
-(void)_rebuildAppListCache;
-(void)_destroyAppListCache;
-(void)_removeCardForDisplayIdentifier:(id)arg1 ;
-(void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
@end

@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;                                         //@synthesize rolesToLayoutItemsMap=_rolesToLayoutItemsMap - In the implementation block
@end

@interface SBRecentAppLayouts: NSObject
+ (id)sharedInstance;
-(id)_recentsFromPrefs;
-(void)remove:(SBAppLayout* )arg1;
-(void)removeAppLayouts:(id)arg1 ;
@end

%group tweak

%hook SBSwitcherAppSuggestionContentView
-(void)didMoveToWindow {
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
		if(darkStyle == 0){
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];  // this changes depending on light/dark mode on iOS 13
		} else if (darkStyle == 1) {
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		} else {
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		}	

		UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		blurEffectView.frame = buttonView.bounds;
		blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[buttonView addSubview:blurEffectView];

		//add subview to main view
		[self insertSubview:buttonView atIndex:10];

		// View constraints
		buttonView.translatesAutoresizingMaskIntoConstraints = false;
		[buttonView.topAnchor constraintEqualToAnchor:self.topAnchor constant:12].active = YES;
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
		UIFont * customFont = [UIFont fontWithName:@"Arial-BoldMT" size:12.5]; //custom font
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

		//set the alpha to 0 for fading in
		fromLabel.alpha = 0;
		buttonView.alpha = 0;


		[UIView animateWithDuration:0.5 animations:^ {
			buttonView.alpha = 1;
			fromLabel.alpha = 1;

		} completion:^(BOOL finished) {
		}];

		addedButton = true;

	} else if (addedButton && transparantButton) {
		[UIView animateWithDuration:0.3 animations:^ {
				buttonView.alpha = 0.6;
				fromLabel.alpha = 1;

			}];
			transparantButton = false;
	}

}


%new

-(void) buttonClicked:(UIButton*)sender {
	id one = @1;

	UIImpactFeedbackGenerator *gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
	[gen prepare];
	[gen impactOccurred];

	//remove the apps
	SBMainSwitcherViewController *mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
    NSArray *items = mainSwitcher.recentAppLayouts;
        for(SBAppLayout * item in items) {
					SBDisplayItem *itemz = [item.rolesToLayoutItemsMap objectForKey:one];
					NSString *bundleID = itemz.bundleIdentifier;
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

	//hide the button
		[UIView animateWithDuration:0.3 animations:^ {
				buttonView.alpha = 0;
				fromLabel.alpha = 0;

			}];
	transparantButton = true;

 }


%end

%hook SBMainSwitcherViewController
//hide the button when going back to the springboard in a smooth way
-(void)switcherContentController:(id)arg1 setContainerStatusBarHidden:(BOOL)arg2 animationDuration:(double)arg3 {
	if (arg2 == false) {
			[UIView animateWithDuration:0.3 animations:^ {
				buttonView.alpha = 0;
				fromLabel.alpha = 0;

			}];
		transparantButton = true;

	}
	%orig;

}
%end

%end


void loadPrefs() {
	HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"com.daveapps.quitallprefs"];
	enabled = [([file objectForKey:@"kEnabled"] ?: @(YES)) boolValue];
	darkStyle = [([file objectForKey:@"kDarkButton"] ?: @(0)) intValue];
	leftButtonPlacement = [([file objectForKey:@"kLeftPlacement"] ?: @(NO)) boolValue];
	dontQuitNowPlaying = [([file objectForKey:@"kKeepMusicAlive"] ?: @(YES)) boolValue];
	dontQuitNavigation = [([file objectForKey:@"kKeepNavAlive"] ?: @(YES)) boolValue];

	if (enabled) {
        %init(tweak);
	}
}



%ctor {
	//load prefs
    loadPrefs();
	// loadFirstFont();
}
