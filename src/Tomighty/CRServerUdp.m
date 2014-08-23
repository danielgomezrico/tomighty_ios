//
//  CRServer.m
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/22/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import "CRServerUdp.h"
#define kPort 8080


@implementation CRServerUdp
@synthesize udpSocket, bgTask, bgExpirationHandler;

#pragma - Constructors

- (instancetype)init
{
    self = [super init];
    if (self){
        bgTask = UIBackgroundTaskInvalid;
    }
    return self;
}

#pragma - Server Life Cicle

-(void) bind
{
    [self startBackground];
    
    //TODO: Manage errors
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // When the job expires it still keeps running since we never exited it. Thus have the expiration handler
        // set a flag that the job expired and use that to exit the while loop and end the task.
        
        udpSocket = [[GCDAsyncUdpSocket alloc]
                     initWithDelegate:self
                     delegateQueue:dispatch_get_main_queue()];
        
        NSError *error = nil;
        if (![udpSocket bindToPort:kPort error:&error]){
            return;
        }
        if (![udpSocket beginReceiving:&error]){
            return;
        }
        
    });
}

-(void) unbind
{
    [udpSocket close];
    [self stopBackground];
}

#pragma - GCDAsyncUdpSocket

- (void)udpSocket:(GCDAsyncUdpSocket *)sock
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    
    NSString *msg = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",msg);
    
    if ([msg isEqualToString:@"TIMER_STOPED"])
    {
        
        [self playSoundNamed:@"Resources/alarm.wav"];
        
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
}

- (BOOL)playSoundNamed:(NSString*)name
{
    NSError *error;
    
    NSString* bundleDirectory = (NSString*)[ [NSBundle mainBundle] bundlePath];
    
    NSURL *url = [NSURL fileURLWithPath:[bundleDirectory stringByAppendingPathComponent:name]];
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                                        error:&error];
    audioPlayer.numberOfLoops = 0;
    
    BOOL success = YES;
    
    if (audioPlayer == nil)
    {
        success = NO;
    }
    else
    {
        success = [audioPlayer play];
    }
    return success;
}


#pragma - Background Life Cicle

- (void)startBackground
{
    UIApplication* app = [UIApplication sharedApplication];
    
    __weak typeof(self) weakSelf = self;
    bgExpirationHandler = ^{
        [app endBackgroundTask:weakSelf.bgTask];
        weakSelf.bgTask = UIBackgroundTaskInvalid;
        weakSelf.bgTask = [app beginBackgroundTaskWithExpirationHandler:weakSelf.bgExpirationHandler];
    };
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:bgExpirationHandler];
}

- (void)stopBackground
{
    UIApplication* app = [UIApplication sharedApplication];
    
    [app endBackgroundTask:self.bgTask];
    bgTask = UIBackgroundTaskInvalid;
}


@end
