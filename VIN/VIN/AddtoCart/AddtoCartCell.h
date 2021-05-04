//
//  AddtoCartCell.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddtoCartCell : UITableViewCell

@property (strong, nonatomic) IBOutlet AsyncImageView *imgSmall;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgBAck;
@property (strong, nonatomic) IBOutlet UILabel *lblnm;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnChmBox;
@property (strong, nonatomic) IBOutlet UILabel *lbl_qty;
@property (strong, nonatomic) IBOutlet UIButton *btn_qty_P;
- (IBAction)btn_qty_P_clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_qty_M;
- (IBAction)btn_qty_M_clicked:(id)sender;


@end
