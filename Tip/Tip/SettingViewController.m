//
//  SettingViewController.m
//  Tip
//
//  Created by Kevin Chang on 2015/6/12.
//  Copyright (c) 2015年 Kevin Chang. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *defautTheme;
@property (strong, nonatomic) IBOutlet UITextField *defaultTip;
@property (strong, nonatomic) IBOutlet UITextField *minTip;
@property (strong, nonatomic) IBOutlet UITextField *maxTip;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    bool defaultTheme = [defaults boolForKey:@"defaultTheme_state"];
    NSString *defaultTip = [defaults stringForKey:@"default_Tip"];
    NSString *minTip = [defaults stringForKey:@"min_Tip"];
    NSString *maxTip  = [defaults stringForKey:@"max_Tip"];
    
    [self.defautTheme setOn:defaultTheme];
    [self.defaultTip setText:([defaultTip length] == 0) ? @"10" : defaultTip];
    [self.minTip setText:([minTip length] == 0) ? @"15" : minTip];
    [self.maxTip setText:([maxTip length] == 0) ? @"20" : maxTip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)themeChange:(UISwitch *)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.on forKey:@"defaultTheme_state"];
}

- (IBAction)tipSetting:(UITextField *)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *tip = nil;
    
    switch (sender.tag) {
        case 0:
            tip = @"default_Tip";
            break;
        case 1:
            tip = @"min_Tip";
            break;
        case 2:
            tip = @"max_Tip";
            break;
        default:
            break;
    }
    
    [defaults setObject:sender.text forKey:tip];
    [defaults synchronize];

}

@end
