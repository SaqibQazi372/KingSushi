//
//  ProductDetail.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "ProductDetail.h"
#import "ConfirmOrder.h"
#import "QrScanner.h"
#import "AppDelegate.h"
@interface ProductDetail ()

@end

@implementation ProductDetail
@synthesize marrgetData,productnm,productDesc,imgvProduct,viewDesc,ViewPrice,marrgetDataforPrice,productID,lblPriceLarge,lblPriceMEdium,lblPriceSmall,btnPriceLarge,btnPriceMedium,btnPriceSmall,txtQty,scrlView,ViewQty;

-(void)AddtoCart
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
        NSString *strPhp = @"add_order.php";
        NSLog(@"price--%@,type--%@",self.strPrice,self.strSize);
        
        NSDictionary *params = @{
                                 @"product_id":productID,
                                 @"price":self.strPrice,
                                 @"item_quantity":txtQty.text,
                                 @"order_id":ORDERID,
                                 @"type":self.strSize
                                 };
        
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             marrprice=[responseObject objectForKey:@"responseData"];
             NSLog(@"%@",marrprice);
             if(![[marrprice valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [CommonFunctions showToastMessage:@"Item add com sucesso"];
                 UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
                 ConfirmOrder *dash = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmOrder"];
                 [self.navigationController pushViewController:dash animated:NO];
             }
             else
             {
                 [CommonFunctions showToastMessage:[marrprice valueForKey:@"message"]];
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
  
    txtQty.layer.borderWidth=1.0;
   
    txtQty.layer.borderColor=[UIColor colorWithHexValue:@"#FDA835"].CGColor;
    
    
    btnPriceSmall.accessibilityLabel=@"On";
    btnPriceMedium.accessibilityLabel=@"Off";
    btnPriceLarge.accessibilityLabel=@"Off";
    
    if([self.priceLarge isEqualToString:@"-"])
        btnPriceLarge.hidden=YES;
    if ([self.priceMed isEqualToString:@"-"])
        btnPriceMedium.hidden=YES;
    if ([self.priceSmall isEqualToString:@"-"])
        btnPriceSmall.hidden=YES;
    
    marrgetData=[[NSMutableArray alloc] init];
    marrgetDataforPrice=[[NSMutableArray alloc] init];
    self.navigationItem.hidesBackButton = YES;
    imgvProduct.imageURL=[NSURL URLWithString:self.catimgUrl];
     productnm.text=[NSString stringWithFormat:@"%@",self.productNm];
     [self setUpBackgroundcolorWithTitle_event:[NSString stringWithFormat:@"%@",self.productNm]];
     productDesc.numberOfLines=0;
     productDesc.lineBreakMode=NSLineBreakByWordWrapping;
     productDesc.text=[NSString stringWithFormat:@"%@",self.catdesc];
     [productDesc sizeToFit];

    lblPriceSmall.text=self.priceSmall;
    lblPriceMEdium.text=self.priceMed;
    lblPriceLarge.text=self.priceLarge;
    
    NSString *stringWithoutSpaces = [lblPriceSmall.text
                                     stringByReplacingOccurrencesOfString:@"$" withString:@""];
    NSLog(@"str%@",stringWithoutSpaces);
    self.strPrice=stringWithoutSpaces;
    NSLog(@"viewDidLoad--%@",self.strPrice);
    self.strSize=@"Small";

     CGFloat height= [self heightOfTextForString:self.catdesc  andFont:[UIFont systemFontOfSize:IS_IPAD?20.0f:15.0f] maxSize:CGSizeMake(productDesc.frame.size.width,MAXFLOAT)];
     viewDesc.frame=CGRectMake(viewDesc.frame.origin.x,viewDesc.frame.origin.y,viewDesc.frame.size.width,21+height+21+10);

     ViewPrice.frame=CGRectMake(ViewPrice.frame.origin.x,viewDesc.frame.origin.y+viewDesc.frame.size.height+7,ViewPrice.frame.size.width, ViewPrice.frame.size.height);
    
    ViewQty.frame=CGRectMake(ViewQty.frame.origin.x, ViewPrice.frame.origin.y+ViewPrice.frame.size.height+7, ViewQty.frame.size.width, ViewQty.frame.size.height);
    
    self.scrlView.contentSize = CGSizeMake(SCREEN_WIDTH,ViewQty.frame.size.height+ViewQty.frame.origin.y);
    
}
-(void)setUpBackgroundcolorWithTitle_event :(NSString *)strTitle
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:@"#9C0025"];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = [NSString stringWithFormat:@"%@",self.catnm];
    lblTitle.font=[UIFont fontWithName:@"Helvetica" size:25.0f];
    
    UIButton *btnMenu=[[UIButton alloc] initWithFrame:CGRectMake(0,0,25,18)];
    [btnMenu setImage:[UIImage imageNamed:@"backArw"] forState:UIControlStateNormal];
    btnMenu.titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.hidesBackButton = NO;
    UIBarButtonItem *barSaveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
    [btnMenu addTarget:self action:@selector(btnBackClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnCart=[[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnCart setImage:[UIImage imageNamed:@"btnCart"] forState:UIControlStateNormal];
    btnCart.titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.hidesBackButton = NO;
    UIBarButtonItem *barCartButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCart];
    [btnCart addTarget:self action:@selector(btnCartClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=barCartButtonItem;
    
    self.navigationItem.titleView=lblTitle;
    self.navigationItem.leftBarButtonItem=barSaveButtonItem;
    
}
-(void)btnCartClicked
{
    UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
    ConfirmOrder *dash = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmOrder"];
    [self.navigationController pushViewController:dash animated:YES];
    
}
-(void)btnBackClicked
{
    APP_DELEGATE.isFromDetail=@"yes";
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{
    // iOS7
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              aFont, NSFontAttributeName,
                                              nil];
        
        CGRect frame = [aString boundingRectWithSize:CGSizeMake(aSize.width, aSize.height)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributesDictionary
                                             context:nil];
        
        CGSize size = frame.size;
        return size.height;
    }
    // iOS6
    CGSize textSize = [aString sizeWithFont:aFont
                          constrainedToSize:aSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(textSize.height);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPriceSmall:(id)sender
{
    if ([btnPriceSmall.accessibilityLabel isEqualToString:@"Off"]) {
        [btnPriceSmall setImage:[UIImage imageNamed:@"btnChkSelected"] forState:UIControlStateNormal];
        NSString *stringWithoutSpaces = [lblPriceSmall.text
                                         stringByReplacingOccurrencesOfString:@"$" withString:@""];
        
        self.strPrice=stringWithoutSpaces;
        self.strSize=@"small";
        [btnPriceLarge setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        [btnPriceMedium setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        btnPriceSmall.accessibilityLabel=@"On";
        btnPriceLarge.accessibilityLabel=@"Off";
        btnPriceMedium.accessibilityLabel=@"Off";
       
    }
}

- (IBAction)btnPriceLarge:(id)sender
{
    if ([btnPriceLarge.accessibilityLabel isEqualToString:@"Off"])
    {
        [btnPriceLarge setImage:[UIImage imageNamed:@"btnChkSelected"] forState:UIControlStateNormal];
        NSString *stringWithoutSpaces = [lblPriceLarge.text
                                         stringByReplacingOccurrencesOfString:@"$" withString:@""];
        
        self.strPrice=stringWithoutSpaces;
        self.strSize=@"large";
        [btnPriceSmall setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        [btnPriceMedium setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        btnPriceLarge.accessibilityLabel=@"On";
        btnPriceSmall.accessibilityLabel=@"Off";
        btnPriceMedium.accessibilityLabel=@"Off";
    }

}
- (IBAction)btnPriceMedium:(id)sender
{
    if ([btnPriceMedium.accessibilityLabel isEqualToString:@"Off"]) {
        [btnPriceMedium setImage:[UIImage imageNamed:@"btnChkSelected"] forState:UIControlStateNormal];
        
        NSString *stringWithoutSpaces = [lblPriceMEdium.text
                                         stringByReplacingOccurrencesOfString:@"$" withString:@""];
    
        self.strPrice=stringWithoutSpaces;
        self.strSize=@"medium";
        [btnPriceSmall setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        [btnPriceLarge setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        btnPriceSmall.accessibilityLabel=@"Off";
        btnPriceMedium.accessibilityLabel=@"On";
        btnPriceLarge.accessibilityLabel=@"Off";
    }
}
- (IBAction)btnAddtpCart:(id)sender
{
    NSLog(@"price---%@",self.strPrice);
    if([btnPriceSmall.accessibilityLabel isEqualToString:@"On"] || [btnPriceMedium.accessibilityLabel isEqualToString:@"On"] || [btnPriceLarge.accessibilityLabel isEqualToString:@"On"])
    {
        if ([CommonFunctions checkIsEmpty:ORDERID]) {
            [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
        }
        else if ([CommonFunctions checkIsEmpty:txtQty.text])
            [CommonFunctions showToastMessage:@"Please enter quantity"];
        else
            if(![CommonFunctions checkIsEmpty:ORDERID])
            {
                [self AddtoCart];
            }
        
    }
    else
    {
        [CommonFunctions showToastMessage:@"Please select type"];
       
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [txtQty resignFirstResponder];
//    [scrlView setContentSize:CGSizeMake(0, scrlView.contentSize.height)];
    [scrlView setContentOffset:CGPointMake(0, scrlView.contentSize.height-scrlView.frame.size.height)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtQty resignFirstResponder];
     [scrlView setContentOffset:CGPointMake(0, scrlView.contentSize.height-scrlView.frame.size.height)];
   
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==txtQty)
    {
        [scrlView setContentOffset:CGPointMake(0, scrlView.contentSize.height-scrlView.frame.size.height)];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==txtQty)
    {
        if (IS_IPHONE_6)
            [scrlView setContentOffset:CGPointMake(0,scrlView.contentSize.height-300) animated:YES];
        else if (IS_IPHONE_5)
             [scrlView setContentOffset:CGPointMake(0,scrlView.contentSize.height-200) animated:YES];
        else if (IS_IPHONE_4s)
            [scrlView setContentOffset:CGPointMake(0,scrlView.contentSize.height-150) animated:YES];

    }
}
@end
