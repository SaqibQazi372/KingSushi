//
//  Menu.h
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController
{
    NSMutableArray *marrResponseData;
}

@property (strong, nonatomic) IBOutlet UITableView *tblMenu;

@property(strong,nonatomic)NSMutableArray *marrgetData;
@property (strong, nonatomic) NSString *isFromcnfirmOrder;
@end
