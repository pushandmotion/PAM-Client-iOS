//
//  PAMClient.h
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackingData.h"

@interface PAMClient : NSObject<NSURLSessionDelegate>

@property(retain,nonatomic)NSString* pamUrl;

-(void)trackPageView:(TrackingData*)data;



@end
