//
//  TipViewController.m
//  Tip
//
//  Created by Kevin Chang on 2015/6/12.
//  Copyright (c) 2015年 Kevin Chang. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (strong, nonatomic) IBOutlet UIView *TipController;
@property (strong, nonatomic) IBOutlet UITextField *billtextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *TipControl;
@property (strong, nonatomic) IBOutlet UILabel *tipAmount;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.billtextField becomeFirstResponder];
    [self themeChange];
    [self tipSettingChang];
    [super viewWillAppear:animated];
}

- (void) themeChange {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    bool defaultTheme = [defaults boolForKey:@"defaultTheme_state"];
    
    self.TipController.backgroundColor = defaultTheme ? [UIColor cyanColor] : [UIColor whiteColor];
}

- (void) tipSettingChang {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultTip = [defaults stringForKey:@"default_Tip"];
    NSString *minTip = [defaults stringForKey:@"min_Tip"];
    NSString *maxTip  = [defaults stringForKey:@"max_Tip"];
    
    [self.TipControl setTitle:[defaultTip stringByAppendingString:@"%"] forSegmentAtIndex:0];
    [self.TipControl setTitle:[minTip stringByAppendingString:@"%"] forSegmentAtIndex:1];
    [self.TipControl setTitle:[maxTip stringByAppendingString:@"%"] forSegmentAtIndex:2];
    
    [defaults synchronize];
    [self Calculate];
}

- (void) Calculate {
    float billAmount = [self.billtextField.text floatValue];
    
    float tipAmount = billAmount * [[self.TipControl titleForSegmentAtIndex:self.TipControl.selectedSegmentIndex] floatValue]/100;
    float totalAmount = tipAmount + billAmount;
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.tipAmount.text = [numberFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:tipAmount]];
    self.totalAmount.text = [numberFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:totalAmount]];
}

- (IBAction)billChange:(UITextField *)sender {
    [self Calculate];
}

- (IBAction)TipChange:(UISegmentedControl *)sender {
    [self.billtextField resignFirstResponder];
    [self Calculate];
}

@end
