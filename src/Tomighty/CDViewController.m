//
//  CDViewController.m
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import "CDViewController.h"

#define kPort 8080

@interface CDViewController ()

@end

@implementation CDViewController
@synthesize udpSocket;

-(void) viewDidLoad
{
    [super viewDidLoad];
	
    udpSocket = [[GCDAsyncUdpSocket alloc]
                 initWithDelegate:self
                 delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    if (![udpSocket bindToPort:kPort error:&error]) //check ff of dit werkt!
    {
        return;
    }
    if (![udpSocket beginReceiving:&error])
    {
        return;
    }
    
    [self playSoundNamed:@"Resources/alarm.wav"];
}

#pragma - GCDAsyncUdpSocket

-(void) udpSocket:(GCDAsyncUdpSocket *)sock
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    
    NSString *msg = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    
    if ([msg isEqualToString:@"TIMER_STOPED"])
    {
        [self playSoundNamed:@"Resources/alarm.wav"];
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    
}

-(BOOL) playSoundNamed:(NSString*)name
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

@end
