//
//  AddtoCart.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "AddtoCart.h"
#import "AddtoCartCell.h"
#import "ProductDetail.h"
#import "ConfirmOrder.h"
#import "QrScanner.h"
#import "AppDelegate.h"
@interface AddtoCart ()
{
    NSString *price,*p_Type;
    
}
@end

@implementation AddtoCart
@synthesize marrgetData,tblAddtoCart,rowPath,strViewShow;
-(void)GetProducts
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
        NSString *strPhp = @"get_products.php";
        
        NSDictionary *params = @{
                                 @"category_id":self.catID,
                                 @"order_id":[CommonFunctions checkIsEmpty:ORDERID]?@"":ORDERID,
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [marrgetData removeAllObjects];
             marrResponseData=[responseObject objectForKey:@"responseData"];
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 for(int i=1;i<=[marrResponseData count];i++)
                 {
                     NSMutableDictionary *marr_dictionary=[marrResponseData valueForKey:[NSString stringWithFormat:@"%d",i] ];
                     [marrgetData addObject:[marr_dictionary mutableCopy]] ;
                 }
                NSLog(@"getData--%@",marrgetData);
                 [self setUpBackgroundcolorWithTitle_event:[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"category_name"] objectAtIndex:0]]];
                 [tblAddtoCart reloadData];
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
-(void)AddtoCart
{
    NSString *product_id,*product_price,*product_qty;
    
        product_id =  [[marr_addtocartarry valueForKey:@"p_id"] componentsJoinedByString:@"@#"];
        product_price = [[marr_addtocartarry valueForKey:@"price"] componentsJoinedByString:@"@#"];
        product_qty = [[marr_addtocartarry valueForKey:@"qty"] componentsJoinedByString:@"@#"];
        
   
    NSLog(@"%@ -- %@ -- %@",product_id,product_price,product_qty);
    
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
        NSDictionary *params = @{
                                 @"product_id":product_id,
                                 @"price":product_price,
                                 @"item_quantity":product_qty,
                                 @"order_id":[CommonFunctions checkIsEmpty:ORDERID]?@"":ORDERID,
                                 @"type":p_Type
                                 
                                 };
        NSLog(@"%@%@%@",VIN_URL,strPhp,params);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             marrResponseDataAddtocart=[responseObject objectForKey:@"responseData"];
             NSLog(@"%@",marrResponseDataAddtocart);
             if(![[marrResponseDataAddtocart valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 [CommonFunctions showToastMessage:@"Item add com sucesso"];
                 UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
                 ConfirmOrder *dash = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmOrder"];
                [self.navigationController pushViewController:dash animated:NO];
             }
             else
             {
//                 [CommonFunctions showToastMessage:@"Please select item"];
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
    ary=[[NSMutableArray alloc] init];
    arynm=[[NSMutableArray alloc] init];
    [ary removeAllObjects];
    marr_addtocartarry = [[NSMutableArray alloc] init];

    self.navigationItem.hidesBackButton = YES;
    marrgetData=[[NSMutableArray alloc] init];
    tblAddtoCart.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
   
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if([APP_DELEGATE.isFromDetail isEqual:@"yes"])
    {
        APP_DELEGATE.isFromDetail=@"no";
    }
    
    [self GetProducts];
    
}
-(void)setUpBackgroundcolorWithTitle_event :(NSString *)strTitle
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:@"#9C0025"];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = [NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"category_name"] objectAtIndex:0]];
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
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma Table Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrgetData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddtoCartCell  *cell  = (AddtoCartCell *)[tblAddtoCart dequeueReusableCellWithIdentifier:@"AddtoCartCell"];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *arrListCell;
        
        arrListCell=[[NSBundle mainBundle]loadNibNamed:@"AddtoCartCell" owner:self options:nil];
        for (id idCell in arrListCell)
        {
            if([idCell isKindOfClass:[UITableViewCell class]])
            {
                cell=(AddtoCartCell *) idCell;
                break;
            }
        }
    }
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        cell.layoutMargins=UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins=NO;
    }
    
    cell.imgSmall.clipsToBounds = YES;
    cell.imgSmall.layer.cornerRadius=40.0f;
    [ cell.imgSmall.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [ cell.imgSmall.layer setBorderWidth: 2.0];
    cell.lblnm.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"product_name"] objectAtIndex:indexPath.row]];
    if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row]])
    {
         cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row]];
         p_Type=@"small";
    }
    else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row]])
    {
        cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row]];
        p_Type=@"medium";
    }
    else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row]])
    {
        cell.lblPrice.text=[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row]];
        p_Type=@"large";
    }
    

//    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"category_name"] objectAtIndex:indexPath.row]]);
    cell.imgBAck.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"image_path"] objectAtIndex:indexPath.row]]];
    cell.imgSmall.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"image_path"] objectAtIndex:indexPath.row]]];
    [cell.btnChmBox addTarget:self action:@selector(btnChkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_qty_P.tag=indexPath.row;
    cell.btn_qty_M.tag=indexPath.row;
    [cell.btn_qty_P addTarget:self action:@selector(btn_qty_P_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn_qty_M addTarget:self action:@selector(btn_qty_M_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnChmBox.tag=indexPath.row;
    
//    if ([[[marrgetData valueForKey:@"is_select"] objectAtIndex:indexPath.row] integerValue]==0) {
        [cell.btnChmBox setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        cell.btnChmBox.accessibilityLabel=@"Off";
//    }
//    else{
//       [cell.btnChmBox setImage:[UIImage imageNamed:@"btnChkSelected"] forState:UIControlStateNormal];
//        cell.btnChmBox.accessibilityLabel=@"On";
//    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tblAddtoCart deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
    ProductDetail *dash = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetail"];
    dash.catID=self.catID;
    NSLog(@"111   %@",marrgetData);
    
    dash.productID=[[marrgetData valueForKey:@"id"] objectAtIndex:indexPath.row];
    
    if ([[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row] isEqual:@""]) {
       dash.priceMed=@"-";
    }
    else{
         dash.priceMed=[NSString stringWithFormat:@"$%@",[[marrgetData valueForKey:@"medium_price"] objectAtIndex:indexPath.row]];
    }
    
   if ([[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row] isEqual:@""]) {
        dash.priceLarge=@"-";
    }
   else{
       dash.priceLarge=[NSString stringWithFormat:@"$%@",[[marrgetData valueForKey:@"large_price"] objectAtIndex:indexPath.row]];
   }
   
    if([[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row] isEqual:@""]) {
        dash.priceSmall=@"-";
    }
    else{
        dash.priceSmall=[NSString stringWithFormat:@"$%@",[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row]];
    }
    NSLog(@"id----%@",[[marrgetData valueForKey:@"id"] objectAtIndex:indexPath.row]);
    dash.catnm=[[marrgetData valueForKey:@"category_name"] objectAtIndex:indexPath.row];
    dash.productNm=[[marrgetData valueForKey:@"product_name"] objectAtIndex:indexPath.row];
    dash.catprice=[[marrgetData valueForKey:@"price"] objectAtIndex:indexPath.row];
    dash.catdesc=[[marrgetData valueForKey:@"description"] objectAtIndex:indexPath.row];
    dash.catimgUrl=[[marrgetData valueForKey:@"image_path"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dash animated:NO];
}
-(void)btn_qty_P_Clicked:(UIButton *)sender
{
    rowPath=sender.tag;
    UIView *info=sender;
    NSIndexPath *myIP =[NSIndexPath indexPathForRow:info.tag inSection:0];
    AddtoCartCell *cell2 = (AddtoCartCell*)[self.tblAddtoCart cellForRowAtIndexPath:myIP];
    
    int current_qty = [cell2.lbl_qty.text intValue];
    current_qty = current_qty + 1;
    [cell2.lbl_qty setText:[NSString stringWithFormat:@"%d", current_qty]];
    
    int current_pid = [[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath] intValue];
    
    for(int j =0 ; j<marr_addtocartarry.count;j++)
    {
        if(current_pid == [[[marr_addtocartarry valueForKey:@"p_id"] objectAtIndex:j]intValue])
        {
            [[marr_addtocartarry objectAtIndex:j] setValue:[NSString stringWithFormat:@"%d",current_qty] forKey:@"qty"];
            
        }
    }
    NSLog(@"marr_addtocartarry%@",marr_addtocartarry);
}

-(void)btn_qty_M_Clicked:(UIButton *)sender
{
    rowPath=sender.tag;
    UIView *info=sender;
    NSIndexPath *myIP =[NSIndexPath indexPathForRow:info.tag inSection:0];
    AddtoCartCell *cell2 = (AddtoCartCell*)[self.tblAddtoCart cellForRowAtIndexPath:myIP];
    
    int current_pid = [[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath] intValue];
    
    int current_qty = [cell2.lbl_qty.text intValue];
    if(current_qty > 1)
    {
    current_qty = current_qty - 1;
    [cell2.lbl_qty setText:[NSString stringWithFormat:@"%d", current_qty]];
        
        for(int j =0 ; j<marr_addtocartarry.count;j++)
        {
            if(current_pid == [[[marr_addtocartarry valueForKey:@"p_id"] objectAtIndex:j]intValue])
            {
                [[marr_addtocartarry objectAtIndex:j] setValue:[NSString stringWithFormat:@"%d",current_qty] forKey:@"qty"];
                
            }
        }
    }
    //NSLog(@"%@",marr_addtocartarry);
    
}
-(void)btnChkBoxClicked:(UIButton *)sender
{
    rowPath=sender.tag;
  
    NSLog(@"%@",[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath]);
   UIView *info=sender;
    NSIndexPath *myIP =[NSIndexPath indexPathForRow:info.tag inSection:0];
    AddtoCartCell *cell2 = (AddtoCartCell*)[self.tblAddtoCart cellForRowAtIndexPath:myIP];

    if ([cell2.btnChmBox.accessibilityLabel isEqualToString:@"Off"])
    {
        [sender setImage:[UIImage imageNamed:@"btnChkSelected"] forState:UIControlStateNormal];
        [[marrgetData objectAtIndex:rowPath] setValue:@"1" forKey:@"is_select"];
        cell2.btnChmBox.accessibilityLabel=@"On";
        
        my_dic = [[NSMutableDictionary alloc] init];
        
        [my_dic setValue:[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath] forKey:@"p_id"];
        if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"price"] objectAtIndex:rowPath]])
        {
           [my_dic setValue:[[marrgetData valueForKey:@"price"] objectAtIndex:rowPath] forKey:@"price"];
        }
        else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"medium_price"] objectAtIndex:rowPath]])
        {
            [my_dic setValue:[[marrgetData valueForKey:@"medium_price"] objectAtIndex:rowPath] forKey:@"price"];
        }
        else if(![CommonFunctions checkIsEmpty:[[marrgetData valueForKey:@"large_price"] objectAtIndex:rowPath]])
        {
            [my_dic setValue:[[marrgetData valueForKey:@"large_price"] objectAtIndex:rowPath] forKey:@"price"];
        }

        
        [my_dic setValue: cell2.lbl_qty.text forKey:@"qty"];
        
        [marr_addtocartarry addObject:my_dic];
        
        [ary addObject:[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath]];
        [arynm addObject:[[marrgetData valueForKey:@"price"] objectAtIndex:rowPath]];
        NSLog(@"ARY--%@",ary);
         [[NSUserDefaults standardUserDefaults] setValue:ary forKey:@"ary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       
    }
    else
    {
        if(ary != nil)
        {
                [ary removeObject:[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath]];
        }
        [[NSUserDefaults standardUserDefaults] setValue:ary forKey:@"ary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [sender setImage:[UIImage imageNamed:@"btnChk"] forState:UIControlStateNormal];
        [[marrgetData objectAtIndex:rowPath] setValue:@"0" forKey:@"is_select"];
        cell2.btnChmBox.accessibilityLabel=@"Off";
        int current_pid = [[[marrgetData valueForKey:@"id"] objectAtIndex:rowPath] intValue];
         NSLog(@"ARY remove--%@",ary);
        for(int j =0 ; j<marr_addtocartarry.count;j++)
        {
            if(current_pid == [[[marr_addtocartarry valueForKey:@"p_id"] objectAtIndex:j]intValue])
            {
                [marr_addtocartarry removeObjectAtIndex:j];
                break;
            }
        }

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAddToCart:(id)sender
{
   

    NSLog(@"Code--%@",QRCODE);
    if ([CommonFunctions checkIsEmpty:QRCODE]) {
        [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
    }
    else
    {
        if(![CommonFunctions checkIsEmpty:ConfirmID])
        {
            [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
            
        }
        else
        {
            if(![CommonFunctions checkIsEmpty:ORDERID])
            {
                [self AddtoCart];
                
                
            }
            else
            {
                [CommonFunctions showToastMessage:@"Por favor escanear O codigo QR em sua mesa"];
            }

        }
    }
}
@end
