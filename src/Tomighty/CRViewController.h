//
//  CDViewController.h
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRServerUdp.h"

@interface CRViewController : UIViewController

@property (nonatomic, strong) CRServerUdp *server;


@end
