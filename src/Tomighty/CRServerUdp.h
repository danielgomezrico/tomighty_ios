//
//  CRServer.h
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/22/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

#import "GCDAsyncUdpSocket.h"


@interface CRServerUdp : NSObject

@property (nonatomic, strong) GCDAsyncUdpSocket *udpSocket;

@property (nonatomic, strong) dispatch_block_t bgExpirationHandler;
@property (nonatomic) UIBackgroundTaskIdentifier bgTask;

-(void) bind;
-(void) unbind;

@end
