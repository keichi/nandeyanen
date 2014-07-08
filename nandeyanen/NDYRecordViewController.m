//
//  NDYRecordViewController.m
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/9/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import "NDYRecordViewController.h"

@interface NDYRecordViewController ()

@end

@implementation NDYRecordViewController
{
    AVAudioRecorder *_audioRecorder;
}

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
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"myvoice.aac"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    NSDictionary *settings = @{AVFormatIDKey: @(kAudioFormatMPEG4AAC),
                               AVNumberOfChannelsKey: @(1)};
    
    NSError *error = nil;
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:recordingURL
                                            settings:settings
                                               error:&error];
    if(error){
        NSLog(@"Error initializing AVAudioRecorder: %@", error);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startButtonTapped:(id)sender {
    [_audioRecorder record];
}

- (IBAction)stopButtonTapped:(id)sender {
    [_audioRecorder stop];
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
