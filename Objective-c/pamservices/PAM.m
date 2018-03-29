//
//  PAM.m
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import "PAM.h"
#import "PAMLocalDataBase.h"
#import "PAMClient.h"

@implementation PAM

+(TrackingDataBuilder*)defaultTrackingData{
    static TrackingDataBuilder *defaultData = nil;
    @synchronized(self) {
        if (defaultData == nil)
            defaultData = [[TrackingDataBuilder alloc] init];
    }
    return defaultData;
}

+(TrackingDataBuilder*)createTackingDataBuilder{
    return [[self defaultTrackingData] clone];
}

+(void)trackUpdfh:(NSString*)updfh{
    [[PAMLocalDataBase getInstance] saveUPDFH:updfh];
    [self defaultTrackingData].updfh = updfh;
    [self trackPageViewWithPagename:@"updfh"];
}

+(void)trackPageViewWithPagename:(NSString*)pageName data:(TrackingData*)data{
    data.page_title = pageName;
    [[self defaultPAMClient] trackPageView:data];
}

+(void)trackPageViewWithPagename:(NSString*)pageName{
    TrackingDataBuilder *builder = [self createTackingDataBuilder];
    builder.page_title = pageName;
    [[self defaultPAMClient] trackPageView:[builder build]];
}

+(void)trackPageViewWithData:(TrackingData*)data{
    [[self defaultPAMClient] trackPageView:data];
}

+(void)trackCustomField:(NSDictionary*)customField{
    TrackingDataBuilder *builder = [self createTackingDataBuilder];
    builder.page_title = @"custom field";
    [[self defaultPAMClient] trackCustomField:[builder build] customField:customField];
}

+(void)initPam:(NSString*)pamUrl appId:(NSString*)appId{
    
    TrackingDataBuilder *defaultData = [self defaultTrackingData];
    defaultData.appId = appId;
    defaultData.counter = 0;
    
    NSString *updfh = [[PAMLocalDataBase getInstance] getUPDFH];
    NSString *mtc_id = [[PAMLocalDataBase getInstance] getMtcID];
    NSString *sid = [[PAMLocalDataBase getInstance] getSID];
    
    if(updfh != nil && ![updfh isEqualToString:@""] ){
        defaultData.updfh = updfh;
    }
    
    if(mtc_id != nil && ![mtc_id isEqualToString:@""]){
        defaultData.mtc_id = mtc_id;
    }
    
    if(sid != nil && ![sid isEqualToString:@""]){
        defaultData.sid = sid;
    }
   
    [self defaultPAMClient].pamUrl = pamUrl;
}

+(PAMClient*)defaultPAMClient{
    static PAMClient *pam = nil;
    @synchronized(self) {
        if (pam == nil)
            pam = [[PAMClient alloc] init];
    }
    return pam;
}


@end
