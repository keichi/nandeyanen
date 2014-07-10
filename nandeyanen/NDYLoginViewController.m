//
//  NDYLoginViewController.m
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/9/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import "NDYLoginViewController.h"

@interface NDYLoginViewController ()

@end

@implementation NDYLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"ログイン" style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonTapped:)];
    self.navigationItem.rightBarButtonItem = loginButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonTapped:(id)sender {
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    [self checkFields];
}

- (void)checkFields
{
    if ([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ほげ"
                                                        message:@"項目が空だよん。"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self loginUser];
}

- (void)loginUser
{
    [PFUser logInWithUsernameInBackground:_usernameField.text password:_passwordField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self performSegueWithIdentifier:@"login" sender:self];
        } else {
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
