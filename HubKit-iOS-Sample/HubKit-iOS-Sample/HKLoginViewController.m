//
//  HKLoginViewController.m
//  HubKit-iOS-Sample
//
//  Created by Josh Johnson on 1/15/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import "HKLoginViewController.h"
#import "HubKit.h"

@interface HKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation HKLoginViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"GitHub";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(didTapLoginButton:)];
}

#pragma mark - Actions

- (IBAction)didTapLoginButton:(id)sender
{
    if ([self.usernameField.text length] > 0 &&
        [self.passwordField.text length] > 0) {
        __weak typeof(self) weak_self = self;
        [self.githubClient loginWithUser:self.usernameField.text password:self.passwordField.text completion:^(NSError *error) {
            if (! error) {
                [weak_self dismissViewControllerAnimated:YES completion:nil];
            }
            weak_self.usernameField.text = nil;
            weak_self.passwordField.text = nil;
        }];
    }
}

@end
