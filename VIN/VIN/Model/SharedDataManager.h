//
//  UIViewController+ImageBackButton.h
//  AtlMessage
//
//  Created by Keshav on 11/02/14.
//  Copyright (c) 2014 Keshav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SharedDataManager : NSObject
{
    FMDatabase      *database;
}
+ (SharedDataManager *)sharedDbManager;
- (id)init;

@property (nonatomic, strong) FMDatabase            *database;
@end     
