/*
 Copyright (c) 2013 Rhys Powell and Josh Johnson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "HKRepositoryViewController.h"
#import "HKLoginViewController.h"
#import "HubKit.h"

@interface HKRepositoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableItems;

@end

@implementation HKRepositoryViewController {}

#pragma mark - UIViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view setAutoresizesSubviews:YES];
    [self.view setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Repositories";
    self.tableItems = @[];
    
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(didTapLogoutButton:)];

}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadRepositories];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"com.hubkit.repoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [self.tableItems objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table Data

- (void)loadRepositories
{
    if (! [HKUser currentUser]) {
        [self loginUser];
    } else {
        [self.githubClient getCurrentUserReposWithCompletion:^(NSArray *collection, NSError *error) {
            if (! error) {
                self.tableItems = [collection map:^id(id object) {
                    NSDictionary *repo = object;
                    return [repo objectForKey:@"name"];
                }];
                
                [self.tableView reloadData];
            } else {
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

- (void)loginUser
{
    HKLoginViewController *loginViewController = [[HKLoginViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.githubClient = self.githubClient;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Actions

- (void)didTapLogoutButton:(id)sender
{
    self.tableItems = @[];
    [self.tableView reloadData];
    
    [HKUser setCurrentUser:nil];
    [self loginUser];
}

#pragma mark - Properties

- (UITableView *)tableView
{
    if (! _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setAutoresizingMask:self.view.autoresizingMask];
    }
    return _tableView;
}

@end
