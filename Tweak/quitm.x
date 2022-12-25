/**
 * This class is dedicated to the quitting of the apps itself. It houses, one
 * function: clearApp. Provide this with the item you want to quit (SBAppLayout),
 * and a switcher object it needs to be quit from.
*/

#import "QuitAll.h"

@implementation QuitManager

// Clear an specific app from the switcher.
-(void)clearApp:(SBAppLayout *)item switcher:(SBMainSwitcherViewController *)switcher excludeList:(NSArray *)excluded {
	NSString *bundleID;
	// Get the id of the app that need to be quit.
	if (@available(iOS 14.0, *)) {
		NSArray *arr = [item allItems];
		SBDisplayItem *itemz = arr[0];
		bundleID = itemz.bundleIdentifier;
    } else {
		SBDisplayItem *itemz = [item.rolesToLayoutItemsMap objectForKey:@1];
		bundleID = itemz.bundleIdentifier;
	}

	// Get the ID of the app currenly playing audio.
	NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];

	// Quit the apps if they are not present in one of the lists
	if (bundleID != NULL && ![excluded containsObject:bundleID] && ![bundleID isEqualToString: nowPlayingID]) {
		if (@available(iOS 14.0, *)) {
			[switcher _deleteAppLayoutsMatchingBundleIdentifier:bundleID];
		} else {
			[switcher _deleteAppLayout:item forReason: 1];
		}
	}
}
@end