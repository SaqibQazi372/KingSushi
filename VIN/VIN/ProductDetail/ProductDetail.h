//
//  ProductDetail.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetail : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *marrResponseData,*marrprice;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrlView;


@property (strong, nonatomic) IBOutlet UIButton *btnPriceSmall;
- (IBAction)btnPriceSmall:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnPriceMedium;
- (IBAction)btnPriceMedium:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnPriceLarge;
- (IBAction)btnPriceLarge:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblPriceSmall;
@property (strong, nonatomic) IBOutlet UILabel *lblPriceMEdium;
@property (strong, nonatomic) IBOutlet UILabel *lblPriceLarge;
- (IBAction)btnAddtpCart:(id)sender;


@property(strong,nonatomic)NSString *strPrice;
@property(strong,nonatomic)NSString *strSize;
@property(strong,nonatomic)NSMutableArray *marrgetData;
@property(strong,nonatomic)NSMutableArray *marrgetDataforPrice;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgvProduct;
@property (strong, nonatomic) IBOutlet UILabel *productnm;
@property (strong, nonatomic) IBOutlet UILabel *productDesc;
@property (strong, nonatomic) IBOutlet UITextField *txtQty;

@property(strong,nonatomic)NSString *productID;
@property(strong,nonatomic)NSString *priceSmall;
@property(strong,nonatomic)NSString *priceMed;
@property(strong,nonatomic)NSString *priceLarge;
@property(strong,nonatomic)NSString *productNm;
@property(strong,nonatomic)NSString *catID;
@property(strong,nonatomic)NSString *catnm;
@property(strong,nonatomic)NSString *catprice;
@property(strong,nonatomic)NSString *catdesc;
@property(strong,nonatomic)NSString *catimgUrl;
@property (strong, nonatomic) IBOutlet UIView *viewDesc;
@property (strong, nonatomic) IBOutlet UIView *ViewPrice;
@property (strong, nonatomic) IBOutlet UIView *ViewQty;

@end
