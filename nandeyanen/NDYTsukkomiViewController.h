//
//  NDYTsukkomiViewController.h
//  nandeyanen
//
//  Created by Keichi Takahashi on 7/8/14.
//  Copyright (c) 2014 Keichi Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <socket.IO/SocketIO.h>

#import "linmath.h"

// TODO Move these constants to a plist file
#define SAMPLING_FREQ       (50.0)
#define HISTORY_LENGTH      (10)
#define SOCKET_IO_SERVER    (@"nandeyanen.keichi.net")
#define SOCKET_IO_PORT      (3456)

typedef enum {
    MSStop,
    MSMoving,
} MovementStatus;

@interface NDYTsukkomiViewController : UIViewController<SocketIODelegate>

@end
