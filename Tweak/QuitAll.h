#import <UIKit/UIKit.h>

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;
@end

@interface SBMediaController : NSObject
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
+(id)sharedInstance;
@end

@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
-(id)recentAppLayouts;
-(void)_deleteAppLayoutsMatchingBundleIdentifier:(id)arg1 ;
@end

@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
-(id)allItems;
@end

@interface SBAppSwitcherScrollView : UIScrollView
@end

@interface QuitManager : NSObject
-(void)clearApp:(SBAppLayout *)item switcher:(SBMainSwitcherViewController *)switcher excludeList:(NSArray *)excluded;
@end