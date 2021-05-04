//
//  Menu.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "Menu.h"
#import "MenuCell.h"
#import "ProductDetail.h"
#import "AddtoCart.h"
#import "ConfirmOrder.h"
#import "FirstViewController.h"
@interface Menu ()

@end

@implementation Menu
@synthesize tblMenu,marrgetData;

-(void)Getcategory
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
        NSString *strPhp = @"get_category.php";
        
      
        NSLog(@"%@%@",VIN_URL,strPhp);
        [manager GET:[NSString stringWithFormat:@"%@%@",VIN_URL,strPhp] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             marrResponseData=[responseObject objectForKey:@"responseData"];
             NSLog(@"%@",marrResponseData);
             if(![[marrResponseData valueForKey:@"result"]isEqualToString:@"failed"])
             {
                 for(int i=1;i<=[marrResponseData count];i++)
                 {
                     NSMutableDictionary *marr_dictionary=[marrResponseData valueForKey:[NSString stringWithFormat:@"%d",i] ];
                     [marrgetData addObject:marr_dictionary];
                 }
                 NSLog(@"%@",marrgetData);
             }
             else
             {
                [CommonFunctions showToastMessage:[marrResponseData valueForKey:@"message"]];
             }
             [tblMenu reloadData];
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
    marrgetData=[[NSMutableArray alloc] init];
    [self Getcategory];
    [self setUpBackgroundcolorWithTitle_event:@"Menu"];
    self.navigationController.navigationBarHidden=NO;
    // Do any additional setup after loading the view.
}
-(void)setUpBackgroundcolorWithTitle_event :(NSString *)strTitle
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:@"#9C0025"];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"Menu";
    lblTitle.font=[UIFont fontWithName:@"Helvetica" size:25.0f];
    
    UIButton *btnMenu=[[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnMenu setImage:[UIImage imageNamed:@"btnMenu"] forState:UIControlStateNormal];
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
    
    self.navigationItem.titleView=lblTitle;
    self.navigationItem.rightBarButtonItem=barCartButtonItem;
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
    
    if (self.isFromcnfirmOrder) {
        UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
        FirstViewController *dash = [storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        [self.navigationController pushViewController:dash animated:NO];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
#pragma Table Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrgetData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self setTableViewheightOfTable:tblMenu ByArrayName:marrgetData];
    MenuCell  *cell  = (MenuCell *)[tblMenu dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *arrListCell;
        
        arrListCell=[[NSBundle mainBundle]loadNibNamed:@"MenuCell" owner:self options:nil];
        for (id idCell in arrListCell)
        {
            if([idCell isKindOfClass:[UITableViewCell class]])
            {
                cell=(MenuCell *) idCell;
                break;
            }
        }
    }
   if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        cell.layoutMargins=UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins=NO;
    }
    cell.lblnm.text=[[marrgetData valueForKey:@"name"] objectAtIndex:indexPath.row];
   cell.img.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[marrgetData valueForKey:@"image_path"] objectAtIndex:indexPath.row]]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tblMenu deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
    AddtoCart *dash = [storyboard instantiateViewControllerWithIdentifier:@"AddtoCart"];
    dash.catID=[[marrgetData valueForKey:@"id"] objectAtIndex:indexPath.row];
    NSLog(@"catID---%@",dash.catID);
    [self.navigationController pushViewController:dash animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
