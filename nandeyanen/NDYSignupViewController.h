//
//  NDYSignupViewController.h
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/9/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface NDYSignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end
