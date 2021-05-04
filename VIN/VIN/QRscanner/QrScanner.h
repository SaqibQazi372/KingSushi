//
//  QrScanner.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//@protocol QRCodeDelegate <NSObject>
//-(void)qrCodeScanned:(BOOL)isScanned withString:(NSString *)strQRCode;
//@end

@interface QrScanner : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    NSString *strQRCode ;
    BOOL isBack;
    NSMutableArray *marrResponseData;
   
//     BOOL isFromQRCode;
//     NSString *stringQRCode;

}
// @property(strong,nonatomic)NSMutableArray *marrgetData;
//@property (weak, nonatomic) IBOutlet UIView *viewPreview;
//
//@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;

- (IBAction)startStopReading:(id)sender;


@end
