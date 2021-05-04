//
//  FirstViewController.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "FirstViewController.h"
#import "Menu.h"
#import "QrScanner.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize btnCallWaiter,btnMenu,btnRequest,marrgetData;
-(void)callWaiter
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
        NSString *strPhp = @"call_waiter.php";
        NSLog(@"OrderId%@",ORDERID);
        NSDictionary *params = @{
                                 @"order_id":ORDERID
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             marrResponseData=[responseObject objectForKey:@"responseData"];
             NSLog(@"%@",marrResponseData);
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [CommonFunctions showToastMessage:@"Você chamou o garçom"];
                 [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"OrderId"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"ConfirmId"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 //[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"QRCode"];
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
             HideHUD;
             HideNetworkActivityIndicator();
         }];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    marrgetData=[[NSMutableArray alloc] init];
    btnMenu.accessibilityLabel=@"Off";
    btnCallWaiter.accessibilityLabel=@"Off";
    btnRequest.accessibilityLabel=@"Off";
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMenu:(id)sender
{
    if ((btnMenu.accessibilityLabel=@"Off"))
    {
      
       [btnMenu setBackgroundImage:[UIImage imageNamed:@"menuTap"] forState:UIControlStateNormal];
        [btnRequest setBackgroundImage:[UIImage imageNamed:@"requests"] forState:UIControlStateNormal];
        [btnCallWaiter setBackgroundImage:[UIImage imageNamed:@"callWaiter"] forState:UIControlStateNormal];
       btnMenu.accessibilityLabel=@"On";
       btnCallWaiter.accessibilityLabel=@"Off";
       btnRequest.accessibilityLabel=@"Off";
        UIStoryboard *storyboard =IS_IPAD?storyboardNameIpad:storyboardNameIphone;
        Menu *PropertyListVC = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
        [self.navigationController pushViewController:PropertyListVC animated:YES];
        
     }
}

- (IBAction)btnCallWaiter:(id)sender {

    NSLog(@"Code--%@",QRCODE);
    if ([CommonFunctions checkIsEmpty:QRCODE]) {
        [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
    }
    else{
        [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [btnRequest setBackgroundImage:[UIImage imageNamed:@"requests"] forState:UIControlStateNormal];
        [btnCallWaiter setBackgroundImage:[UIImage imageNamed:@"callwaiterTap"] forState:UIControlStateNormal];
        btnCallWaiter.accessibilityLabel=@"On";
        btnMenu.accessibilityLabel=@"Off";
        btnRequest.accessibilityLabel=@"Off";
        if(![CommonFunctions checkIsEmpty:ORDERID])
        {
            [self callWaiter];
        }
        else
        {
            [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
        }
        
    }
}
- (IBAction)btnRequest:(id)sender
{
    if ((btnRequest.accessibilityLabel=@"Off"))
        {
            [btnCallWaiter setBackgroundImage:[UIImage imageNamed:@"callWaiter"] forState:UIControlStateNormal];
            [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
            [btnRequest setBackgroundImage:[UIImage imageNamed:@"requestTap"] forState:UIControlStateNormal];
            btnRequest.accessibilityLabel=@"On";
            btnCallWaiter.accessibilityLabel=@"Off";
            btnMenu.accessibilityLabel=@"Off";
            
            UIStoryboard *storyboard =IS_IPAD?storyboardNameIpad:storyboardNameIphone;
            QrScanner *PropertyListVC = [storyboard instantiateViewControllerWithIdentifier:@"QrScanner"];
            [self.navigationController pushViewController:PropertyListVC animated:YES];
        }

}

-(void)qrCodeScanned:(BOOL)isScanned withString:(NSString *)strQRCode
{
    NSLog(@"delegate called");
    isFromQRCode = isScanned;
    stringQRCode = strQRCode;
    [[NSUserDefaults standardUserDefaults] setValue:strQRCode forKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"delegate call---%@",QRCODE);
}

@end
