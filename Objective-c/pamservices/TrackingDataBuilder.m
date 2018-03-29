//
//  TrackingDataBuilder.m
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import "TrackingDataBuilder.h"
#import <UIKit/UIKit.h>

@implementation TrackingDataBuilder

-(TrackingData*)build{
    TrackingData *data = [[TrackingData alloc] init];
    data.page_title = self.page_title;
    data.page_referrer = self.page_referrer;
    data.page_url = self.page_url;
    data.counter = self.counter;
    data.appId = self.appId;
    data.mtc_id = self.mtc_id;
    data.sid = self.sid;
    
    if(self.updfh != nil){
        data.updfh = self.updfh;
    }
    
    if(self.resolution == nil){
        [self setResolutionExactAsDeviceScreen];
    }
    data.resolution = self.resolution;
    
    if(self.page_language == nil){
        [self setPageLanguageFromDeviceConfiguarion];
    }
    data.page_language = self.page_language;
    
    data.timezone_offset = [self getTimezoneOffset];
    
    return data;
}

-(TrackingDataBuilder*)clone{
    TrackingDataBuilder *builder = [[TrackingDataBuilder alloc] init];
    builder.appId = self.appId;
    builder.mtc_id = self.mtc_id;
    builder.updfh = self.updfh;
    builder.page_title = self.page_title;
    builder.page_language = self.page_language;
    builder.page_referrer = self.page_referrer;
    builder.page_url = self.page_url;
    builder.counter = self.counter;
    builder.resolution = self.resolution;
    builder.sid = self.sid;
    return builder;
}

-(void)setPageLanguageFromDeviceConfiguarion{
    self.page_language = [[NSLocale preferredLanguages] firstObject];
}

-(void)setResolutionFromString:(NSString*)res{
    self.resolution = res;
}

-(void)setResolutionFromWidth:(int)w height:(int)h{
    self.resolution = [NSString stringWithFormat:@"%dx%d",w,h];
}

-(void)setResolutionExactAsDeviceScreen{
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    self.resolution = [NSString stringWithFormat:@"%dx%d",w,h];
}

-(NSNumber*)getTimezoneOffset{
    NSInteger millisecondsFromGMT = [[NSTimeZone localTimeZone] secondsFromGMT]/60;
    return @(millisecondsFromGMT*-1);
}

@end
