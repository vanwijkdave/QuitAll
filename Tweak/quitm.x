#import "QuitAll.h"

@implementation QuitManager
-(void)clearApp:(SBAppLayout *)item switcher:(SBMainSwitcherViewController *)switcher {    
	NSMutableDictionary *ALApps = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.dave.quitall.plist"];
	NSMutableArray *ALArray = [[NSMutableArray alloc] init];

	for(id key in ALApps) {
	id value = [ALApps objectForKey:key];
		if ([value boolValue] == true) {
			[ALArray addObject: key];
			
		}
	}

	bool quitApp = true;
	if (@available(iOS 14.0, *)) {
			NSArray *arr = [item allItems];
			SBDisplayItem *itemz = arr[0];

			NSString *bundleID = itemz.bundleIdentifier;
			NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];


			if ([ALArray containsObject:bundleID] || [bundleID isEqualToString: nowPlayingID]) {
				quitApp = false;
				return;
			} else {
				quitApp = true;
			}


			if (quitApp) {
				[switcher _deleteAppLayoutsMatchingBundleIdentifier:bundleID];
			}

    } else {
		SBDisplayItem *itemz = [item.rolesToLayoutItemsMap objectForKey:@1];
		NSString *bundleID = itemz.bundleIdentifier;
			NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];


		if ([ALArray containsObject:bundleID] || [bundleID isEqualToString: nowPlayingID]) {
			quitApp = false;
			return;
		} else {
			quitApp = true;
		}

		if (quitApp) {
			[switcher _deleteAppLayout:item forReason: 1];
		}
	}
}
@end