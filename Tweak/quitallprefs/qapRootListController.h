#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#include <spawn.h>
#import "SparkAppListTableViewController.h"

@interface qapRootListController : PSListController
@property (nonatomic, retain) UIBarButtonItem *respringButton;
    - (void)respring:(id)sender;
@end
