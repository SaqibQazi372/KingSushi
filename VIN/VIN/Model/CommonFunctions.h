//
//  CommonFunctions.h
//  GrabMySpace
//
//  Created by Keshav on 05/12/13.
//  Copyright (c) 2013 Keshav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
//#import "METoast.h"
#import "UIView+Toast.h"


@interface CommonFunctions : NSObject
+(void)showNoNetworkError;
+(NSString *) stringByStrippingHTML :(NSString *)s;
+(BOOL) checkIsEmpty:(NSString *) s1;
+(NSString *) myTrim:(NSString *) string;
+(NSString *)removeWhiteSpaces :(NSString *)stringValue;
+(BOOL)networkConnected;
+ (UIImage*) ellipseWithImage:(UIImage *) originalImage;
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(void)showAlertMessage : (NSString *)bodyString;
+(BOOL)IsValidEmail:(NSString *)checkString;
+(void)showToastMessage :(NSString *)message;
+(UIImage *) userBackgroundImage;
+(void)showHUDWithString:(NSString *)string andView :(UIView *)view;
+(NSString *)getMonthNameFromInt:(int)number;
+(UIImage *) screenshot :(UIView *)view;
+(NSString *) formatPhone: (NSString *) unformattedString;
+(void)showNoInternetErrorMessage;
+(NSMutableString *)insertcharter :(NSMutableString *)str length:(NSInteger)pointsstrlen;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height;
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(NSString *)getmonthName:(NSInteger)monthno;
+(int)getNumberFromMonthName:(NSString *)monthName;
+(BOOL)validateUrl: (NSString *) candidate;
+(UIImage *)scaleAndRotateImage:(UIImage *)image;
//+(UIView *)starlevel1:(NSInteger)userpoints;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;
+(NSString *) stringByStrippingHTML1 :(NSString *)s;
+(UIImage *)compressImage:(UIImage *)image;
+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;
+ (int)lineCountForLabel:(UILabel *)label;
//+(void)showCustomHUD;
//+(void)hideCustomHUD;
//+(NSString *)setLanguage:(NSString *)str_id;
@end
