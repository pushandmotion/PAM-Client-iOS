//
//  PAMLocalDataBase.h
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PAMLocalDataBase : NSObject{
    @private sqlite3 *database;
}

+(PAMLocalDataBase*)getInstance;
-(id)init;
-(void)saveMtcID:(NSString*)mtc_id sid:(NSString*)sid;
-(NSString*)getMtcID;
-(NSString*)getSID;
-(void)saveUPDFH:(NSString*)updfh;
-(NSString*)getUPDFH;

@end
