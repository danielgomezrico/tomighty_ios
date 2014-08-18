//
//  CDViewController.h
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import "GCDAsyncUdpSocket.h"

@interface CDViewController : UIViewController

@property (nonatomic, strong) GCDAsyncUdpSocket *udpSocket;

@end
