//Interfaces
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

@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
-(id)recentAppLayouts;
-(void)_rebuildAppListCache;
-(void)_destroyAppListCache;
-(void)_removeCardForDisplayIdentifier:(id)arg1 ;
-(void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
-(void)_deleteAppLayoutsMatchingBundleIdentifier:(id)arg1 ;

@end

@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;                                         //@synthesize rolesToLayoutItemsMap=_rolesToLayoutItemsMap - In the implementation block
-(id)allItems;

@end

@interface SBRecentAppLayouts: NSObject
+ (id)sharedInstance;
-(id)_recentsFromPrefs;
-(void)remove:(SBAppLayout* )arg1;
-(void)removeAppLayouts:(id)arg1 ;
@end

@interface SBSwitcherAppSuggestionContentView: UIView
-(void)clearApp:(SBAppLayout *)item switcher:(SBMainSwitcherViewController *)switcher; 
@end
