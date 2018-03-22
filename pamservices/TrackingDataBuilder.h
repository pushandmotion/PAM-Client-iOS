//
//  TrackingDataBuilder.h
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackingData.h"

@interface TrackingDataBuilder : NSObject

@property(retain,nonatomic)NSString* page_title;
@property(retain,nonatomic)NSString* page_language;
@property(retain,nonatomic)NSString* page_referrer;
@property(retain,nonatomic)NSString* page_url;
@property(retain,nonatomic)NSString* resolution;
@property(retain,nonatomic)NSString* updfh;
@property(retain,nonatomic)NSString* appId;
@property(retain,nonatomic)NSString* mtc_id;
@property(retain,nonatomic)NSString* sid;
@property(retain,nonatomic)NSNumber* counter;

-(TrackingData*)build;
-(TrackingDataBuilder*)clone;
-(void)setPageLanguageFromDeviceConfiguarion;

-(void)setResolutionFromString:(NSString*)res;
-(void)setResolutionFromWidth:(int)w height:(int)h;
-(void)setResolutionExactAsDeviceScreen;
-(NSNumber*)getTimezoneOffset;

@end
