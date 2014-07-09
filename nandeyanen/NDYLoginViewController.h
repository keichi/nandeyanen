//
//  NDYLoginViewController.h
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/9/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NDYLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
