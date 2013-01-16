//
//  HKLoginViewController.m
//  HubKit-iOS-Sample
//
//  Created by Josh Johnson on 1/15/13.
//  Copyright (c) 2013 HubKit. All rights reserved.
//

#import "HKLoginViewController.h"
#import "HKHTTPClient.h"

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

        [self.githubClient logInUserWithUsername:self.usernameField.text password:self.passwordField.text success:^(AFJSONRequestOperation *operation, id responseObject) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(AFJSONRequestOperation *operation, NSError *error) {
            self.usernameField.text = nil;
            self.passwordField.text = nil;
        }];
    }
}

@end
