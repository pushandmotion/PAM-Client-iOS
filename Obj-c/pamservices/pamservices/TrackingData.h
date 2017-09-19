//
//  TrackingData.h
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackingData : NSObject

@property(retain,nonatomic)NSString* page_title;
@property(retain,nonatomic)NSString* page_language;
@property(retain,nonatomic)NSString* page_referrer;
@property(retain,nonatomic)NSString* page_url;
@property(retain,nonatomic)NSString* appId;
@property(retain,nonatomic)NSString* resolution;
@property(retain,nonatomic)NSString* platform;
@property(retain,nonatomic)NSString* do_not_track;
@property(retain,nonatomic)NSString* adblock;
@property(retain,nonatomic)NSString* updfh;
@property(retain,nonatomic)NSString* mtc_id;
@property(retain,nonatomic)NSString* sid;

@property(retain,nonatomic)NSNumber* timezone_offset;
@property(retain,nonatomic)NSNumber* counter;

-(NSString*)getFingerPrint;
-(NSDictionary*)toDictionary;

@end
