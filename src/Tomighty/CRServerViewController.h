//
//  CDViewController.h
//  Tomighty
//
//  Created by Daniel Gomez Rico on 8/18/14.
//  Copyright (c) 2014 Cuadru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRServerUdp.h"

@interface CRServerViewController : UIViewController

@property (nonatomic, strong) CRServerUdp *server;
@property (weak, nonatomic) IBOutlet UILabel *textStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imageStatus;

@end
