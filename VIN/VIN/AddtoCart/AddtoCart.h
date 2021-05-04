//
//  AddtoCart.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddtoCart : UIViewController
{
    NSMutableArray *marrResponseData,*marrResponseDataAddtocart,*ary,*arynm,*marr_addtocartarry;
    NSMutableDictionary *my_dic;
}@property(strong,nonatomic)NSString *catID;
@property (strong, nonatomic) IBOutlet UITableView *tblAddtoCart;
@property(strong,nonatomic)NSMutableArray *marrgetData;
@property(nonatomic) NSInteger rowPath;
- (IBAction)btnAddToCart:(id)sender;
@property (strong, nonatomic) NSString *strViewShow;
@end
