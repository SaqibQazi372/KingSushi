//
//  UIViewController+ImageBackButton.h
//  AtlMessage
//
//  Created by Keshav on 11/02/14.
//  Copyright (c) 2014 Keshav. All rights reserved.
//
#import "SharedDataManager.h"

@implementation SharedDataManager
@synthesize database;
+ (SharedDataManager *)sharedDbManager  {
	static SharedDataManager *sharedDbManager;
    
	@synchronized(self) {
		if(!sharedDbManager) {
			sharedDbManager     = [[SharedDataManager alloc] init];
		}
	}
	return sharedDbManager;
}
- (id)init
{
    
    self = [super init];
	if (self != nil)
	{
        if(!self.database) {
            self.database       = [FMDatabase databaseWithPath:kDB_PATH];
        }
    }
    [self copyDatabaseToPath];
    [self openDb];
    return self;
}
-(void) copyDatabaseToPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    if(![fileManager fileExistsAtPath:kDB_PATH]) {
        NSString *fromPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDB_NAME];
        [fileManager copyItemAtPath:fromPath toPath:kDB_PATH error:nil];
    }
}
-(void) openDb {
    if (![self.database open]) {
        NSLog(@"Could not open db.");
    }
}
@end

