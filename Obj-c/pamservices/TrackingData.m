//
//  TrackingData.m
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import "TrackingData.h"
#import "FingerPrint.h"
#import "PAM.h"

@implementation TrackingData

-(TrackingData*)init{
    if( self = [super init] ){
        self.platform = @"iOS";
        self.do_not_track = @"unspecified";
        self.adblock = @"false";
        return self;
    }
    return nil;
}

-(NSString*)getFingerPrint{
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                    self.updfh,
                    self.appId,
                    self.page_language,
                    self.resolution,
                    self.timezone_offset ,
                    self.platform,
                    self.adblock
                    ];
   
    if(self.page_title != nil){
        str = [str stringByAppendingString:self.page_title];
    }
    
    if(self.page_referrer != nil){
        str = [str stringByAppendingString:self.page_title];
    }
    
    if(self.page_url != nil){
        str = [str stringByAppendingString:self.page_title];
    }
    
    if(self.counter != nil){
        str = [str stringByAppendingString:self.page_title];
    }
    
    return [FingerPrint fromString:str];
}

-(NSDictionary*)toDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.appId forKey:@"app_id"];
    [dict setObject:self.page_language forKey:@"page_language"];
    [dict setObject:self.resolution forKey:@"resolution"];
    [dict setObject:self.timezone_offset forKey:@"timezone_offset"];
    [dict setObject:self.platform forKey:@"platform"];
    [dict setObject:self.do_not_track forKey:@"do_not_track"];
    [dict setObject:self.adblock forKey:@"adblock"];
    
    if(self.updfh != nil) {
       [dict setObject:self.updfh forKey:@"updfh"];
    }
    
    if(self.page_title != nil){
        [dict setObject:self.page_title forKey:@"page_title"];
    }
    
    if(self.page_referrer != nil){
        [dict setObject:self.page_referrer forKey:@"page_referrer"];
    }
    
    if(self.page_url != nil){
        [dict setObject:self.page_url forKey:@"page_url"];
        [PAM defaultTrackingData].page_referrer = self.page_url;
    }
    
    if(self.counter != nil){
        [dict setObject:self.counter forKey:@"counter"];
    }
    
    if(self.mtc_id != nil){
        [dict setObject:self.mtc_id forKey:@"mtc_id"];
    }
    
    if(self.sid != nil){
        [dict setObject:self.sid forKey:@"sid"];
    }
    
    [dict setObject:[self getFingerPrint] forKey:@"fingerprint"];
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
