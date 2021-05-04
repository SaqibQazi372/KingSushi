//
//  ConfirmOrder.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrder : UIViewController
{
    NSMutableArray *marrResponseData,*marrDeleteData,*marrConfirmData;
//    NSMutableArray *grandPrice;
}
@property (strong, nonatomic) IBOutlet UITableView *tblCnfirmOrder;
@property(strong,nonatomic) NSString *strnm;
@property(strong,nonatomic) NSString *strPrice;
@property(strong,nonatomic) NSString *strid;

@property (strong, nonatomic) IBOutlet UIImageView *ImgView;
@property (strong, nonatomic) IBOutlet UIView *ViewEdit;
@property (strong, nonatomic) IBOutlet UILabel *lblNm;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtQty;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
- (IBAction)btnEdit:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblGrandTotal;
@property (strong, nonatomic) IBOutlet UIView *viewBelowEdit;

@property (strong, nonatomic) IBOutlet UIButton *btnEdit;


- (IBAction)btnConfirm:(id)sender;
@property(nonatomic) NSInteger rowPath;
@property(strong,nonatomic)NSMutableArray *marrgetData;
@property(strong,nonatomic)NSMutableArray *grandPrice;
@end
