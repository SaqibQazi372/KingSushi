//
//  QrScanner.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "QrScanner.h"
#import <AVFoundation/AVFoundation.h>
@interface QrScanner ()
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;

@end

@implementation QrScanner

//@synthesize marrgetData;
-(void)GetQR
{
    
    Reachability* reach=[Reachability reachabilityForInternetConnection];
    NetworkStatus networkstatus=[reach currentReachabilityStatus];
    if (networkstatus==NotReachable)
    {
        [CommonFunctions showNoNetworkError];
    }
    else
    {
        ShowHUD;
        ShowNetworkActivityIndicator();
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *strPhp = @"qr_scan.php";
    
//        [CommonFunctions showAlertMessage:[NSString stringWithFormat:@"%@",strQRCode]];
        NSDictionary *params = @{@"code":strQRCode
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             marrResponseData=[responseObject objectForKey:@"responseData"];
             NSLog(@"%@",marrResponseData);
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [CommonFunctions showToastMessage:@"Você já pode fazer seu pedido"];
                 [[NSUserDefaults standardUserDefaults] setValue:[marrResponseData valueForKey:@"order_id"] forKey:@"OrderId"];
                 [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"ConfirmId"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [[NSUserDefaults standardUserDefaults] setValue:strQRCode forKey:@"QRCode"];
                                  NSLog(@"%@",QRCODE);
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [CommonFunctions showToastMessage:[marrResponseData valueForKey:@"message"]];
             }
             
             HideHUD;
             HideNetworkActivityIndicator();
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
//             [CommonFunctions showAlertMessage:@"failure called"];

             HideHUD;
             HideNetworkActivityIndicator();
         }];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    strQRCode = @"0000000184000013";
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden=NO;
    [self setUpBackgroundcolorWithTitle_event:@"QR Code"];
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction method implementation

- (IBAction)startStopReading:(id)sender {
    if (!_isReading) {
        
        if ([self startReading]) {
            
            [_bbitemStart setTitle:@"Stop"];
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
                [self stopReading];
                [_bbitemStart setTitle:@"Start!"];
    }
    
        _isReading = !_isReading;
}


#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
                NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
//
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}
-(void)btnBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setUpBackgroundcolorWithTitle_event :(NSString *)strTitle
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:@"#9C0025"];
    self.navigationController.navigationBar.translucent = NO;

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"QR Code";
    lblTitle.font=[UIFont fontWithName:@"Helvetica" size:25.0f];

    UIButton *btnMenu=[[UIButton alloc] initWithFrame:CGRectMake(0,0,25,18)];
    [btnMenu setImage:[UIImage imageNamed:@"backArw"] forState:UIControlStateNormal];
    btnMenu.titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.hidesBackButton = NO;
    UIBarButtonItem *barSaveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
    [btnMenu addTarget:self action:@selector(btnBackClicked) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView=lblTitle;
    self.navigationItem.leftBarButtonItem=barSaveButtonItem;

}
-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])
        {
            strQRCode=[metadataObj stringValue];
            

            [self GetQR];

            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            _isReading = NO;
            
            
            if (_audioPlayer)
            {
                [_audioPlayer play];
            }
        }
    }
}
@end
