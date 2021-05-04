//
//  UIColor+color.m
//  Vocal Photo
//
//  Created by Keshav Infotech on 6/11/15.
//  Copyright (c) 2015 keshav. All rights reserved.
//

#import "UIColor+color.h"

@implementation UIColor (color)
+ (UIColor *)colorWithHueDegrees:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness {
    return [UIColor colorWithHue:(hue/360) saturation:saturation brightness:brightness alpha:1.0];
}

+ (UIColor *)aquaColor
{
 //   return [UIColor colorWithHueDegrees:210 saturation:1.0 brightness:0.0];
    return [UIColor colorWithRed:0 green:255 blue:255 alpha:0.3];
}

+ (UIColor *)paleYellowColor {
    return [UIColor colorWithHueDegrees:60 saturation:0.2 brightness:1.0];
}

@end
