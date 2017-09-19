//
//  PAMLocalDataBase.m
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import "PAMLocalDataBase.h"

#define DB_NAME @"pam.sqlite"

@implementation PAMLocalDataBase

+(PAMLocalDataBase*)getInstance{
    static PAMLocalDataBase *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(id)init{
    if( self = [super init] ){
        return self;
    }
    return nil;
}

-(void)saveMtcID:(NSString*)mtc_id sid:(NSString*)sid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mtc_id forKey:@"mtc_id"];
    [defaults setObject:sid forKey:@"sid"];
    [defaults synchronize];
}

-(void)saveUPDFH:(NSString*)updfh{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:updfh forKey:@"updfh"];
    [defaults synchronize];
}

-(NSString*)getMtcID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"mtc_id"];
}

-(NSString*)getSID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"sid"];
}

-(NSString*)getUPDFH{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"updfh"];
}

@end




