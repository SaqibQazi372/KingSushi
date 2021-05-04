//
//  AppDelegate.m
//  VIN
//
//  Created by Keshav Infotech on 1/11/16.
//  Copyright (c) 2016 Keshav Infotech. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end
@implementation UIScrollView (HideKeyboard)


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.superview  touchesBegan:touches withEvent:event];
}

@end
@implementation AppDelegate
@synthesize isFromDetail;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIStoryboard *storyboard = IS_IPAD?storyboardNameIpad:storyboardNameIphone;
    UIViewController *controller;
    controller = [storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = navigationController;
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"QRCode"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderId"];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [CommonFunctions showToastMessage:[NSString stringWithFormat:@"orderId---%@,QrCode---%@",ORDERID,QRCODE]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderId"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
