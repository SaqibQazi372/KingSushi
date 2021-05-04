//
//  Constant.h
//  GrabMySpace
//
//  Created by Keshav on 05/12/13.
//  Copyright (c) 2013 Keshav. All rights reserved.
//

#ifndef GrabMySpace_Constant_h
#define GrabMySpace_Constant_h

#pragma mark - iOS Version

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - Device

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4s (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5                     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define colorstr  [[NSUserDefaults standardUserDefaults] valueForKey:@"colorstr"]
#define colorindex [[NSUserDefaults standardUserDefaults] valueForKey:@"colorindex"]

#define IS_LANDSCAPE                    (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
#pragma mark - Screen Size

//#define     SCREEN_WIDTH        [ [ UIScreen mainScreen ] bounds ].size.width
//#define     SCREEN_HEIGHT       [ [ UIScreen mainScreen ] bounds ].size.height

//#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
//#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)


#pragma mark - WebServices


#define VIN_URL @"https://sushiresturant.000webhostapp.com/webservices/"
#pragma mark - Activity Indicator

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define ShowHUD [MBProgressHUD showHUDAddedTo:self.view animated:YES]
#define HideHUD [MBProgressHUD hideAllHUDsForView:self.view animated:YES]
#define storyboardNameIphone  [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define storyboardNameIpad  [UIStoryboard storyboardWithName:@"MainIpad" bundle:nil]

#pragma mark - User Details

#define latitude1 [[NSUserDefaults standardUserDefaults] valueForKey:@"lat1"]
#define longitude1 [[NSUserDefaults standardUserDefaults] valueForKey:@"long1"]
#define QRCODE [[NSUserDefaults standardUserDefaults] valueForKey:@"QRCode"]
#define ORDERID [[NSUserDefaults standardUserDefaults] valueForKey:@"OrderId"]
#define ConfirmID [[NSUserDefaults standardUserDefaults] valueForKey:@"ConfirmId"]
#define ARY [[NSUserDefaults standardUserDefaults] valueForKey:@"ary"]

//#define USERTYPE [[NSUserDefaults standardUserDefaults] valueForKey:@"UserType"]
//#define EMAIL [[NSUserDefaults standardUserDefaults] valueForKey:@"Email"]
//#define ProFileIMG [[NSUserDefaults standardUserDefaults] valueForKey:@"profileimage"]

//fb
#define FirstNm [[NSUserDefaults standardUserDefaults] valueForKey:@"FirstNm"]
#define LastNm [[NSUserDefaults standardUserDefaults] valueForKey:@"LastNm"]
//twitter
#define twitterUserNM [[NSUserDefaults standardUserDefaults] valueForKey:@"TwitterUserNM"]


#define IS_LOCAL_SAVED [[NSUserDefaults standardUserDefaults] valueForKey:@"savedInLocal"]
#define CURRENT_LANGUAGE [[NSUserDefaults standardUserDefaults] valueForKey:@"currentLanguage"]
#define flag_language [[NSUserDefaults standardUserDefaults] valueForKey:@"flag_language"]

#pragma mark Database

#define kDATA_STORAGE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDB_NAME           @"dbletsell.sqlite"
#define kDB_PATH           [kDATA_STORAGE_PATH stringByAppendingPathComponent:kDB_NAME]
#define kSHARED_INSTANCE    [SharedDataManager sharedDbManager]
#define kDATABASE           [kSHARED_INSTANCE database]


//#pragma -mark Category_id
//#define cat_id [[NSUserDefaults standardUserDefaults] valueForKey:@"catid"]
//
//#pragma -mark subCategory_id
//#define subcat_id [[NSUserDefaults standardUserDefaults] valueForKey:@"subcatid"]

#define swipeGestureView  UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(popView)];

//#define NSLog(...)

#define APP_DELEGATE                    ((AppDelegate *)[[UIApplication sharedApplication]delegate])

#define hideNavigationvBar() self.navigationController.navigationBarHidden = YES
#define showNavigationvBar() self.navigationController.navigationBarHidden = NO
#endif
