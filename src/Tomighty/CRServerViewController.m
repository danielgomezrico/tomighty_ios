//
//  CDViewController.m
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import "CRServerViewController.h"


@implementation CRServerViewController

@synthesize server, textStatus, imageStatus;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    server = [[CRServerUdp alloc] init];
    [server bind];
    
}


- (IBAction)buttonStartTouchDown:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Start"])
    {
        textStatus.text = @"Started";
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [imageStatus setImage:[UIImage imageNamed:@"server_image_running"]];
        
        [server bind];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Stop"])
    {
        textStatus.text = @"Stoped";
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [imageStatus setImage:[UIImage imageNamed:@"server_image_stoped"]];
        
        [server unbind];
    }
}


@end
