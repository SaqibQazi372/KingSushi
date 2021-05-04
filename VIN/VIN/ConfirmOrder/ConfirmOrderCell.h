//
//  ConfirmOrderCell.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lnlnm;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalPrice;

@end
