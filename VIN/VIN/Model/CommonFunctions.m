//
//  CommonFunctions.m
//  GrabMySpace
//
//  Created by Keshav on 05/12/13.
//  Copyright (c) 2013 Keshav. All rights reserved.
//

#import "CommonFunctions.h"
#import <UIKit/UIKit.h>
#import <MapKit/MKPlacemark.h>
#import <QuartzCore/CALayer.h>
#import "MBProgressHUD.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"

UIImageView *imgHUD;
UIWindow *currentWindow;

@implementation CommonFunctions

-(void)passwordMessageSuccess{
    
//    UIView *viewPwd=[[UIView alloc]initWithFrame:CGRectMake(35 , 400, 250, 40)];
//    viewPwd.layer.cornerRadius=20;
//    viewPwd.clipsToBounds=YES;
//    [viewPwd setBackgroundColor:[UIColor colorWithHexValue:@"#5F4D54"]];
//    
//    
//    UILabel *lblMsg=[[UILabel alloc]initWithFrame:CGRectMake(20,5, 230, 30)];
//    [lblMsg setFont:[UIFont systemFontOfSize:12]];
//    [lblMsg setTextColor:[UIColor whiteColor]];
//    [lblMsg setText:@"Password has been sent successfully"];
//    [viewPwd addSubview:lblMsg];
//    
//    [self.view addSubview:viewPwd];
//    
//    
//    viewPwd.hidden = NO;
//    viewPwd.alpha = 1.0f;
//    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
//    [UIView animateWithDuration:.6 delay:.2 options:1 animations:^{
//        // Animate the alpha value of your imageView from 1.0 to 0.0 here
//        viewPwd.alpha = 0.3f;
//    } completion:^(BOOL finished) {
//        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
//        viewPwd.alpha = 0.0f;
//        //        viewPwd.hidden = YES;
//    }];
    
}

+(void)showNoNetworkError {
    //    METoastAttribute *attr = [[METoastAttribute alloc] init];
    //    attr.location = METoastLocationTop;
    //    [METoast setToastAttribute:attr];
    //    [METoast toastWithMessage:@" No Internet Connection "];
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow makeToast:@" No Internet Connection "];
    
}


+(NSMutableString *)insertcharter :(NSMutableString *)str length:(NSInteger)pointsstrlen
{
    if(pointsstrlen==4)
    {
        [str insertString:@"," atIndex:1];
    }
    else if(pointsstrlen==5)
    {
        [str insertString:@"," atIndex:2];
    }
    else if(pointsstrlen==6)
    {
        [str insertString:@"," atIndex:1];
        [str insertString:@"," atIndex:4];
    }
    else if(pointsstrlen==7)
    {
        [str insertString:@"," atIndex:1];
        [str insertString:@"," atIndex:5];
    }
    return str;
}


+(void)showNoInternetErrorMessage{
    
}

+(UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    return image;
}
+(NSString *) stringByStrippingHTML :(NSString *)s
{
    NSRange r;
    while ((r = [s rangeOfString:@"\\<[^\\>]*\\>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
       
        //s = [s stringByReplacingCharactersInRange:r withString:@"\n"];
        s=[s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}
+(NSString *) stringByStrippingHTML1 :(NSString *)s
{
    NSRange r;
    while ((r = [s rangeOfString:@"\\<[^\\>]*\\>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        
        s = [s stringByReplacingCharactersInRange:r withString:@"\n"];
    }
    return s;
}

+(BOOL) checkIsEmpty:(NSString *) s1
{
//    if ([s isEqual:[NSNull null]]) return YES;
//    s = [self myTrim:[NSString stringWithFormat:@"%@",s]];
//    if([s isEqualToString:@"(null)"]) s = @"";
//    return ([s isEqualToString:@""])?YES:NO;
    if ([s1 isEqual:[NSNull null]]) return YES;
    s1 = [self myTrim:[NSString stringWithFormat:@"%@",s1]];
    if([s1 isEqualToString:@"(null)"]) s1 = @"";
    else if ([s1 isEqualToString:@"<null>"]) s1=@"";
    return ([s1 isEqualToString:@""])?YES:NO;

}
+(NSString *) myTrim:(NSString *) string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+(NSString *)removeWhiteSpaces :(NSString *)stringValue{
    NSString *trimmedString = [stringValue stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}
+(BOOL)networkConnected
{
    
//    Reachability* reach=[Reachability reachabilityForInternetConnection];
//    NetworkStatus networkstatus=[reach currentReachabilityStatus];
//    if(networkstatus!=NotReachable)
//    {
//        NSLog(@"rechable");
//    }
//    else
//    {
//        NSLog(@"not recahble");
//    }
    return YES;
  //  return [AFNetworkReachabilityManager sharedManager].reachable;
}
+ (UIImage*) ellipseWithImage:(UIImage *) originalImage
{
    CGRect circleRect=CGRectMake(0,0,50,50);
    CGSize size = circleRect.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGRect clipRect=CGRectMake(circleRect.origin.x,circleRect.origin.y, size.width, size.height-8);
    CGContextSetLineWidth(context, 8);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, clipRect);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    UIImage *image = [self imageWithImage:originalImage scaledToSize:size];
    [image drawInRect:clipRect];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(void)showAlertMessage:(NSString *)bodyString {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"VIN" message:bodyString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
+(BOOL)IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//+(void)showNoNetworkError
//{
//    METoastAttribute *attr = [[METoastAttribute alloc] init];
//    attr.location = METoastLocationTop;
//    [METoast setToastAttribute:attr];
//    [METoast toastWithMessage:@"No Internet Connection"];
//}
+(void)showToastMessage :(NSString *)message {
    //    METoastAttribute *attr = [[METoastAttribute alloc] init];
    //    attr.location = METoastLocationTop;
    //    [METoast setToastAttribute:attr];
    //    [METoast toastWithMessage:message];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow makeToast:message];
}
+(UIImage *) userBackgroundImage {
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/userBackground.png", documentsDirectoryPath]];
    
    return result;
}
+(void)showHUDWithString:(NSString *)string andView :(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view withText:string];
}
+(NSString*)getMonthNameFromInt:(int)number {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *monthName = [[df monthSymbols] objectAtIndex:(number-1)];
    
    return monthName;
}
+(UIImageView *)ShowBlurImage :(UIView *)view withRadius:(CGFloat)radius {
    UIImageView *ivImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    ivImage.image = [self screenshot:view];
    ivImage.backgroundColor = [UIColor clearColor];
    return ivImage;
}
+(UIImage *) screenshot :(UIView *)view
{
    
    CGRect rect;
    rect=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+(NSString *) formatPhone: (NSString *) unformattedString

{
    NSString * returnString = unformattedString;
    NSCharacterSet* nonNumbers = [[NSCharacterSet
                                   characterSetWithCharactersInString:@"01234567890"] invertedSet];
    
    NSRange r = [unformattedString rangeOfCharacterFromSet: nonNumbers];
    
    if (r.location == NSNotFound)
    {
        NSRange areaCode = {0, 3};
        NSRange prefix = {3, 3};
        NSRange suffix = {6, 4};
        if ((unformattedString.length == 10) && (! [unformattedString hasPrefix:@"1"]))
        {
            returnString = [NSString stringWithFormat:@"(%@) %@-%@", [unformattedString substringWithRange:areaCode], [unformattedString substringWithRange:prefix],[unformattedString substringWithRange:suffix]];
        }
    }
    
    return returnString;
}

//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
//    } else {
//        UIGraphicsBeginImageContext(size);
//    }
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self imageWithImage:image scaledToSize:newSize];
}
+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    BOOL isLandscape;
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(-delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, -delta/2);
    }
    
    //for retina consideration
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    [image drawAtPoint:offset];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+(NSString *)getmonthName:(NSInteger)monthno
{
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)monthno];
    if([inStr isEqual:@"1"])
        inStr=@"January";
    else if([inStr isEqual:@"2"])
        inStr=@"February";
    else if([inStr isEqual:@"3"])
        inStr=@"March";
    else if([inStr isEqual:@"4"])
        inStr=@"April";
    else if([inStr isEqual:@"5"])
        inStr=@"May";
    else if([inStr isEqual:@"6"])
        inStr=@"June";
    else if([inStr isEqual:@"7"])
        inStr=@"July";
    else if([inStr isEqual:@"8"])
        inStr=@"August";
    else if([inStr isEqual:@"9"])
        inStr=@"September";
    else if([inStr isEqual:@"10"])
        inStr=@"Octomber";
    else if([inStr isEqual:@"11"])
        inStr=@"November";
    else if([inStr isEqual:@"12"])
        inStr=@"December";
    return inStr;
}
+(int)getNumberFromMonthName:(NSString *)monthName
{
    //    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)monthno];
    //
    int monthNumber;
    
    if([monthName isEqual:@"Jan"])
        monthNumber=1;
    else if([monthName isEqual:@"Feb"])
        monthNumber=2;
    else if([monthName isEqual:@"Mar"])
        monthNumber=3;
    else if([monthName isEqual:@"Apr"])
        monthNumber=4;
    else if([monthName isEqual:@"May"])
        monthNumber=5;
    else if([monthName isEqual:@"Jun"])
        monthNumber=6;
    else if([monthName isEqual:@"Jul"])
        monthNumber=7;
    else if([monthName isEqual:@"Aug"])
        monthNumber=8;
    else if([monthName isEqual:@"Sep"])
        monthNumber=9;
    else if([monthName isEqual:@"Oct"])
        monthNumber=10;
    else if([monthName isEqual:@"Nov"])
        monthNumber=11;
    else if([monthName isEqual:@"Dec"])
        monthNumber=12;
    
    return monthNumber;
}
+(BOOL)validateUrl: (NSString *) candidate
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}
+(UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    float width = newSize.width;
    float height = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    //indent in case of width or height difference
    float offset = (width - height) / 2;
    if (offset > 0) {
        rect.origin.y = offset;
    }
    else {
        rect.origin.x = -offset;
    }
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}
+(UIImage *)compressImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
}

+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{
    // iOS7
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              aFont, NSFontAttributeName,
                                              nil];
        
        CGRect frame = [aString boundingRectWithSize:CGSizeMake(aSize.width, aSize.height)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributesDictionary
                                             context:nil];
        
        CGSize size = frame.size;
        return size.height;
    }
    // iOS6
    CGSize textSize = [aString sizeWithFont:aFont
                          constrainedToSize:aSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(textSize.height);
    
}
+ (int)lineCountForLabel:(UILabel *)label
{
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return ceil(size.height / label.font.lineHeight);
}

//+(NSString *)setLanguage:(NSString *)str_id
//{
//    NSString *translation;
//    
//    NSString *strgetQuery=[NSString stringWithFormat:@"select * from language where id = %@",str_id];
//    FMResultSet *resultSet = [kDATABASE executeQuery:strgetQuery];
//    
//    while ([resultSet next])
//    {
//        NSLog(@"%@",flag_language);
//        
//        if ([App_effect_language isEqualToString:@"Turkish"])
//        {
//            translation = [resultSet stringForColumn:@"turkish"];
//        }
//        else if ([App_effect_language isEqualToString:@"English"])
//        {
//            translation = [resultSet stringForColumn:@"english"];
//        }
//        else if ([App_effect_language isEqualToString:@"Arabic"])
//        {
//            translation = [resultSet stringForColumn:@"arabic"];
//        }
//        else
//        {
//            translation = [resultSet stringForColumn:@"english"];
//        }
//        
//    }
//    
//    return translation;
//}
//
//+(void)showCustomHUD
//{
//    currentWindow = [UIApplication sharedApplication].keyWindow;
//    imgHUD = [[UIImageView alloc] init];
//    imgHUD.frame = CGRectMake(currentWindow.center.x-25, currentWindow.center.y-25, 50, 50);
//    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"load" withExtension:@"gif"];
//    imgHUD.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url1]];
//    imgHUD.image = [UIImage animatedImageWithAnimatedGIFURL:url1];
//    [currentWindow addSubview:imgHUD];
//}
//
//+(void)hideCustomHUD
//{
//    [imgHUD removeFromSuperview];
//}
//

@end
