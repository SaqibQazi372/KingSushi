//
//  FirstViewController.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QrScanner.h"
//<QRCodeDelegate>
@interface FirstViewController : UIViewController

{
    BOOL isFromQRCode;
    NSString *stringQRCode;
    NSMutableArray *marrResponseData;
   
}

@property(strong,nonatomic)NSMutableArray *marrgetData;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnCallWaiter:(id)sender;
- (IBAction)btnRequest:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIButton *btnRequest;
@property (strong, nonatomic) IBOutlet UIButton *btnCallWaiter;

@end
