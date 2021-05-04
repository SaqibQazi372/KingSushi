//
//  AddtoCartCell.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "AddtoCartCell.h"

@implementation AddtoCartCell

- (void)awakeFromNib {
    // Initialization code
    self.btnChmBox.accessibilityLabel=@"Off";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btn_qty_P_clicked:(id)sender {
}
- (IBAction)btn_qty_M_clicked:(id)sender {
}
@end
