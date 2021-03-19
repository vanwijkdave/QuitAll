#include "qapRootListController.h"


@implementation qapRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
-(void)selectExcludeApps
{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.daveapps.quitallprefs" andKey:@"excludedApps"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}

- (instancetype)init {
    self = [super init];





    if (self) {

        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:0.76 green:0.23 blue:0.29 alpha:1.0];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];

        self.hb_appearanceSettings = appearanceSettings;

		self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(respring:)];
        self.respringButton.tintColor = [UIColor colorWithRed:0.76 green:0.23 blue:0.29 alpha:1.0];
		self.navigationItem.rightBarButtonItem = self.respringButton;


    }

    return self;
}

- (void)respring:(id)sender {
    pid_t pid;
    int status;
    const char* argv[] = {"sbreload", NULL};
    posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)argv, NULL);
    waitpid(pid, &status, WEXITED);
}

- (void)twitterDave {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/davewijk"]];
}


- (void)SourceCode {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/vanwijkdave/QuitAll"]];
}

- (void)donateDave {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.redcross.org/donate/donation.html/"]];
}

@end
