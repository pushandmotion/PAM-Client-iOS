//
//  PAM.h
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackingDataBuilder.h"
#import "TrackingData.h"

@interface PAM : NSObject

+(void)init:(NSString*)pamUrl appId:(NSString*)appId;

+(TrackingDataBuilder*)defaultTrackingData;
+(TrackingDataBuilder*)createTackingDataBuilder;

+(void)trackUpdfh:(NSString*)updfh;
+(void)trackPageViewWithPagename:(NSString*)pageName;
+(void)trackPageViewWithData:(TrackingData*)data;
+(void)trackPageViewWithPagename:(NSString*)pageName data:(TrackingData*)data;


@end