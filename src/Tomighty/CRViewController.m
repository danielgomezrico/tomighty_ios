//
//  CDViewController.m
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import "CRViewController.h"


@implementation CRViewController
@synthesize server;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    server = [[CRServerUdp alloc] init];
    [server bind];
    
}

@end
