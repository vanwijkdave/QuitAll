#import <Cephei/HBPreferences.h>

@interface SBSwitcherAppSuggestionContentView: UIView
@end

@interface SBSwitcherAppSuggestionContentView (QuitAll)
- (void)_quitAllReloadPrefs;
@end

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;
@end

@interface SBMediaController : NSObject
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
+ (id)sharedInstance;
@end

@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
- (id)recentAppLayouts;
- (void)_rebuildAppListCache;
- (void)_destroyAppListCache;
- (void)_removeCardForDisplayIdentifier:(id)arg1 ;
- (void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
@end

@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
@end

@interface SBRecentAppLayouts: NSObject
+ (id)sharedInstance;
- (id)_recentsFromPrefs;
- (void)remove:(SBAppLayout* )arg1;
- (void)removeAppLayouts:(id)arg1 ;
@end