//
//  ConfirmOrder.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "ConfirmOrder.h"
#import "ConfirmOrderCell.h"
#import "Menu.h"
#import "AddtoCart.h"
@interface ConfirmOrder ()

{
    NSString *totalPrice;
}
@end

@implementation ConfirmOrder
@synthesize tblCnfirmOrder,marrgetData,rowPath,ImgView,ViewEdit,lblNm,lblPrice,lblTotal,txtQty,grandPrice;
   float sum=0;

-(void)deleteOrder
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
        NSString *strPhp = @"delete_item.php";
        NSLog(@"Id%@",[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath]);
        NSDictionary *params = @{
                                 @"id":[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath],
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             marrResponseData=[responseObject objectForKey:@"responseData"];
             NSLog(@"------%@",marrResponseData);
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [marrgetData removeAllObjects];
                 
                 [self GetOrder];
             }
             else
             {
                 [CommonFunctions showToastMessage:[marrResponseData valueForKey:@"message"]];
             }
             [tblCnfirmOrder reloadData];
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

-(void)EditOrder
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
        NSString *strPhp = @"edit_order.php";
        NSLog(@"Id%@",[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath]);
        NSDictionary *params = @{
                                 @"product_id":[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath],
                                 @"order_id":ORDERID,
                                 @"item_quantity":txtQty.text,
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             marrResponseData=[responseObject objectForKey:@"responseData"];
             NSLog(@"------%@",marrResponseData);
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [self GetOrder];
             }
             else
             {
                 [CommonFunctions showToastMessage:[marrResponseData valueForKey:@"message"]];
             }
             [tblCnfirmOrder reloadData];
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

-(void)GetOrder
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
        NSString *strPhp = @"get_order.php";
        NSLog(@"OrderId%@",ORDERID);
        NSDictionary *params = @{
                                 @"order_id":[CommonFunctions checkIsEmpty:ORDERID]?@"":ORDERID
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        if ([CommonFunctions checkIsEmpty:ORDERID]) {
            [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
            HideHUD;
        }
        else{
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             ViewEdit.hidden=YES;
             ImgView.hidden=YES;
             [marrgetData removeAllObjects];
             marrResponseData=[responseObject objectForKey:@"responseData"];
             
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 for(int i=1;i<=[marrResponseData count];i++)
                 {
                     NSMutableDictionary *marr_dictionary=[marrResponseData valueForKey:[NSString stringWithFormat:@"%d",i] ];
                     [marrgetData addObject:[marr_dictionary mutableCopy]] ;
                 }
                [grandPrice removeAllObjects];
              for (int i=0; i<[marrgetData count]; i++)
              {
                  NSString *strprice;
                 if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"price"] objectAtIndex:i]])
                 {
                     strprice=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"price"] objectAtIndex:i]];
                 }
                 else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"medium_price"] objectAtIndex:i]])
                 {
                     strprice=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"medium_price"] objectAtIndex:i]];
                 }
                 else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"large_price"] objectAtIndex:i]])
                 {
                     strprice=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"large_price"] objectAtIndex:i]];
                 }

                 NSArray *items = [strprice componentsSeparatedByString:@","];
                 NSString *price=[NSString stringWithFormat:@"%@",[items objectAtIndex:0]];
                 NSString *qunty=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"item_quantity"] objectAtIndex:i]];
                 long total=[price integerValue]*[qunty integerValue];
                 totalPrice=[NSString stringWithFormat:@"%ld",total];
                 
                 [grandPrice addObject:totalPrice];
                 NSLog(@"%@",grandPrice);
              }
              
              sum=0;
              for (int i=0; i<[grandPrice count]; i++)
              {
                  float price=[[grandPrice objectAtIndex:i] floatValue];
                  sum=sum+price;
              }
              self.lblGrandTotal.text=[NSString stringWithFormat:@"%ld,00",(long)sum];
             }
             else
             {

                 [CommonFunctions showToastMessage:@"Seu carrinho está vazio!"];
                self.lblGrandTotal.text=@"0,00";
             }
             
             [tblCnfirmOrder reloadData];
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
}
-(void)ConfirmOrder
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
        NSString *strPhp = @"confirm_order.php";
        NSLog(@"OrderId%@",ORDERID);
        NSDictionary *params = @{
                                 @"order_id":ORDERID
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
           
            marrConfirmData=[responseObject objectForKey:@"responseData"];
            NSLog(@"------%@",marrConfirmData);
             if(![[marrConfirmData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [CommonFunctions showToastMessage:@"Seu pedido foi feito"];
                 self.lblGrandTotal.text=@"0,00";
                 [marrgetData removeAllObjects];
                 [tblCnfirmOrder reloadData];
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"confirmOrder"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self.navigationController popToRootViewControllerAnimated:NO];

                 
             }
             else
             {
                 [CommonFunctions showToastMessage:[marrConfirmData valueForKey:@"message"]];
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
    UIView *viewTXT=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtQty.frame.size.height)];
    txtQty.leftView=viewTXT;
    txtQty.leftViewMode=UITextFieldViewModeAlways;
    
    marrgetData=[[NSMutableArray alloc] init];
    grandPrice=[[NSMutableArray alloc] init];
    [self setUpBackgroundcolorWithTitle_event:@"Confirmar pedido"];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UITapGestureRecognizer *ImageviewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTapGesture)];
    self.ImgView.userInteractionEnabled=YES;
    [self.ImgView addGestureRecognizer:ImageviewTapRecognizer];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txtQty.inputAccessoryView = keyboardDoneButtonView;
    
    
    if (IS_IPHONE_5) {
        ViewEdit.frame=CGRectMake(ViewEdit.frame.origin.x, ViewEdit.frame.origin.y-100, ViewEdit.frame.size.width, ViewEdit.frame.size.height);
    }
    if (IS_IPHONE_4s) {
        ViewEdit.frame=CGRectMake(ViewEdit.frame.origin.x, ViewEdit.frame.origin.y-150, ViewEdit.frame.size.width, ViewEdit.frame.size.height);
    }
}
- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [txtQty resignFirstResponder];

}
- (void)ActionTapGesture
{
    self.ImgView.hidden=YES;
    ViewEdit.hidden=YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtQty resignFirstResponder];
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self GetOrder];
}
-(void)setUpBackgroundcolorWithTitle_event :(NSString *)strTitle
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:@"#9C0025"];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"Confirmar pedido";
    lblTitle.font=[UIFont fontWithName:@"Helvetica" size:25.0f];
    
    UIButton *btnMenu=[[UIButton alloc] initWithFrame:CGRectMake(0,0,25,18)];
    [btnMenu setImage:[UIImage imageNamed:@"backArw"] forState:UIControlStateNormal];

    UIButton *btnAdd=[[UIButton alloc] initWithFrame:CGRectMake(0,0,20,20)];
    [btnAdd setImage:[UIImage imageNamed:@"btnPlus"] forState:UIControlStateNormal];
    UIBarButtonItem *barAddButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    [btnAdd addTarget:self action:@selector(btnAddClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=barAddButtonItem;
    
    
    self.navigationItem.hidesBackButton = NO;
    UIBarButtonItem *barSaveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
    [btnMenu addTarget:self action:@selector(btnBackClicked) forControlEvents:UIControlEventTouchUpInside];
    tblCnfirmOrder.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.titleView=lblTitle;
    self.navigationItem.leftBarButtonItem=barSaveButtonItem;
   
}
-(void)btnAddClicked
{
    UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
    Menu *dash = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];

    dash.isFromcnfirmOrder=@"yes";
    [self.navigationController pushViewController:dash animated:NO];
}
-(void)btnBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma Table Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrgetData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmOrderCell  *cell  = (ConfirmOrderCell *)[tblCnfirmOrder dequeueReusableCellWithIdentifier:@"ConfirmOrderCell"];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *arrListCell;
        
        arrListCell=[[NSBundle mainBundle]loadNibNamed:@"ConfirmOrderCell" owner:self options:nil];
        for (id idCell in arrListCell)
        {
            if([idCell isKindOfClass:[UITableViewCell class]])
            {
                cell=(ConfirmOrderCell *) idCell;
                break;
            }
        }
    }
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        cell.layoutMargins=UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins=NO;
    }
   
    if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row]])
    {
        cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row]];
    }
    else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row]])
    {
        cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row]];
    }
    else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row]])
    {
        cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row]];
    }

    cell.lnlnm.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"product_name"] objectAtIndex:indexPath.row]];
    cell.lblQty.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"item_quantity"] objectAtIndex:indexPath.row]];
    [cell.btnDelete addTarget:self action:@selector(btnDeleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnDelete.tag=indexPath.row;
    NSArray *items = [cell.lblPrice.text componentsSeparatedByString:@","];
    NSString *price=[NSString stringWithFormat:@"%@",[items objectAtIndex:0]];
    long total=[price integerValue]*[cell.lblQty.text integerValue];
    cell.lblTotalPrice.text=[NSString stringWithFormat:@"%ld,00",total];
   

    
    
    [cell.btnEdit addTarget:self action:@selector(btnEditClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnEdit.tag=indexPath.row;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tblCnfirmOrder deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtQty resignFirstResponder];
    //    [scrlView setContentSize:CGSizeMake(0, scrlView.contentSize.height)];
}
-(void)btnDeleteClicked:(UIButton *)sender
{
    rowPath=sender.tag;
    NSLog(@"row--%ld",(long)rowPath);
    [self deleteOrder];
    
}

-(void)btnEditClicked:(UIButton *)sender
{
    rowPath=sender.tag;
    NSLog(@"row--%ld",(long)rowPath);
    ImgView.hidden=NO;
    ViewEdit.hidden=NO;
    lblNm.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"product_name"] objectAtIndex:rowPath]];
    lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"price"] objectAtIndex:rowPath]];
    txtQty.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"item_quantity"] objectAtIndex:rowPath]];
//    lblTotal.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"total_price"] objectAtIndex:rowPath]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnEdit:(id)sender
{
    [txtQty resignFirstResponder];
    if ([CommonFunctions checkIsEmpty:txtQty.text])
        [CommonFunctions showToastMessage:@"Please enter quantity"];
    else
        [self EditOrder];
}

- (IBAction)btnConfirm:(id)sender
{
    if(![CommonFunctions checkIsEmpty:ConfirmID])
    {
        [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
     
    }
    else
    {
        [self ConfirmOrder];
        [[NSUserDefaults standardUserDefaults]setValue:ORDERID forKey:@"ConfirmId"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    
    
}
@end
