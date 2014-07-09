//
//  NDYLoginViewController.m
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/9/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import "NDYSignupViewController.h"

@interface NDYSignupViewController ()

@end

@implementation NDYSignupViewController
{
    AVAudioRecorder *_audioRecorder;
    NSString *_voicePath;
    BOOL _isRecording;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
        NSString *documentDir = [filePaths objectAtIndex:0];
        _voicePath = [documentDir stringByAppendingPathComponent:@"myvoice.aac"];
        NSURL *recordingURL = [NSURL fileURLWithPath:_voicePath];
        
        NSDictionary *settings = @{AVFormatIDKey: @(kAudioFormatMPEG4AAC),
                                   AVNumberOfChannelsKey: @(1)};
        
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:recordingURL
                                                    settings:settings
                                                       error:&error];
        if(error){
            NSLog(@"Error initializing AVAudioRecorder: %@", error);
        }
        
        _isRecording = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonTapped:(id)sender {
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_rePasswordField resignFirstResponder];
    
    [self checkInputFields];
}

- (void)checkInputFields
{
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ほげ"
                                                        message:@"空の項目があります。"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![_passwordField.text isEqualToString:_rePasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ほげ"
                                                        message:@"パスワードが一致してまへん。"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self registerUser];
}

- (void)registerUser
{
    PFFile *file = [PFFile fileWithName:@"myvoice" contentsAtPath:_voicePath];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Handle success or failure here ...
        if (succeeded) {
            PFUser *user = [PFUser user];
            user.username = _usernameField.text;
            user.email = _emailField.text;
            user.password = _passwordField.text;
            user[@"voice"] = file;
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self performSegueWithIdentifier:@"signup" sender:self];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ほげ"
                                                                    message:@"登録できまへんでした。"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }];
        } else {
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
    }];
}
- (IBAction)recordButtonTapped:(id)sender {
    if (_isRecording) {
        _isRecording = NO;
        [_audioRecorder stop];
        [_recordButton setTitle:@"録音" forState:UIControlStateNormal];
    } else {
        _isRecording = YES;
        [_audioRecorder record];
        [_recordButton setTitle:@"停止" forState:UIControlStateNormal];
    }
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
