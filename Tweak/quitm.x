#import "QuitAll.h"
#import "SparkAppList.h"

@implementation QuitManager
-(void)clearApp:(SBAppLayout *)item switcher:(SBMainSwitcherViewController *)switcher {
	if (@available(iOS 14.0, *)) {
			NSArray *arr = [item allItems];
			SBDisplayItem *itemz = arr[0];

			NSString *bundleID = itemz.bundleIdentifier;
			NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];

			BOOL containsBundleID = [SparkAppList doesIdentifier:@"com.daveapps.quitallprefs" andKey:@"excludedApps" containBundleIdentifier:bundleID];
			if (containsBundleID || [bundleID isEqualToString: nowPlayingID]) {
				return;
			} else {
				[switcher _deleteAppLayoutsMatchingBundleIdentifier:bundleID];
			}

    } else {
		SBDisplayItem *itemz = [item.rolesToLayoutItemsMap objectForKey:@1];
		NSString *bundleID = itemz.bundleIdentifier;
		NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];

		BOOL containsBundleID = [SparkAppList doesIdentifier:@"com.daveapps.quitallprefs" andKey:@"excludedApps" containBundleIdentifier:bundleID];
		if (containsBundleID || [bundleID isEqualToString: nowPlayingID]) {
			return;
		} else {
			[switcher _deleteAppLayout:item forReason: 1];
		}
	}
}
@end