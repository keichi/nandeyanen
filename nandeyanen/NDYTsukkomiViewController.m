//
//  NDYTsukkomiViewController.m
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/8/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import "NDYTsukkomiViewController.h"

@interface NDYTsukkomiViewController ()

@end

@implementation NDYTsukkomiViewController
{
    CMMotionManager *_motionManager;
    NSMutableArray *_accelerationHistory;
    MovementStatus _movementStatus;;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        _accelerationHistory = [NSMutableArray arrayWithCapacity:HISTORY_LENGTH];
        _movementStatus = MSStop;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _motionManager = [CMMotionManager new];
    
    if (_motionManager.deviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 1.0 / SAMPLING_FREQ;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            vec3 gravity, userAcceleration, e1, e2;
            
            // Gravitational acceleration vector
            gravity[0] = motion.gravity.x;
            gravity[1] = motion.gravity.y;
            gravity[2] = motion.gravity.z;
            
            // User acceleration vector (without gravitational acceleration)
            userAcceleration[0] = motion.userAcceleration.x;
            userAcceleration[1] = motion.userAcceleration.y;
            userAcceleration[2] = motion.userAcceleration.z;
            
            // Calculate basis vectors parallel to the ground
            vec3_mul_cross(e1, userAcceleration, gravity);
            vec3_mul_cross(e2, e1, gravity);
            vec3_norm(e1, e1);
            vec3_norm(e2, e2);
            
            float acc1 = vec3_mul_inner(userAcceleration, e1);
            float acc2 = vec3_mul_inner(userAcceleration, e2);
            float acc = sqrt(acc1 * acc1 + acc2 * acc2);
            
            if (_accelerationHistory.count == HISTORY_LENGTH) {
                [_accelerationHistory removeObjectAtIndex:0];
            }
            [_accelerationHistory addObject:@(acc)];
            float currentVelocity = 0.0f;
            for (NSNumber *num in _accelerationHistory) {
                currentVelocity += [num floatValue];
            }
            currentVelocity *= _accelerationHistory.count * (1.0f / SAMPLING_FREQ);
            
            if (_movementStatus == MSStop && currentVelocity > 5.0f) {
                _movementStatus = MSMoving;
            } else if (_movementStatus == MSMoving && currentVelocity < 1.0f) {
                _movementStatus = MSStop;
                [self doTsukkomi];
            }
         }];
    } else {
        NSLog(@"Device motion is not available.");
    }
}

- (void)doTsukkomi
{
    NSLog(@"なんでやねん!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
