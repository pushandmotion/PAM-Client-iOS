//
//  PAMClient.m
//  pamservices
//
//  Created by heart on 9/8/2560 BE.
//  Copyright © 2560 heart. All rights reserved.
//

#import "PAMClient.h"
#import "PAM.h"
#import "PAMLocalDataBase.h"

@implementation PAMClient


-(void)trackPageView:(TrackingData*)data{
    NSString *url = [self createEventURL:@"rest/event"];
    if( PAM.debugMode ){
        NSLog(@"PAM >> SEND TRACK url=%@ MTC_ID = %@",url,data.mtc_id);
    }
    [self postTo:url data:[data toDictionary]];
}

-(void)trackCustomField:(TrackingData*)data customField:(NSDictionary*)customField{
    NSString *url = [self createEventURL:@"rest/event"];
     if( PAM.debugMode ){
         NSLog(@"PAM >> SEND TRACK url=%@ MTC_ID = %@",url,data.mtc_id);
     }
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:[data toDictionary]];
    for(id key in customField){
        [mDict setObject:key forKey:customField[key]];
    }
    
    [self postTo:url data:mDict];
}

-(NSString*)createEventURL:(NSString*)subfix{
    if( [[self.pamUrl substringFromIndex:self.pamUrl.length-1] isEqualToString:@"/"] ){
        return [NSString stringWithFormat:@"%@%@",self.pamUrl,subfix];
    }
    return [NSString stringWithFormat:@"%@/%@",self.pamUrl,subfix];;
}

-(void)onTrackingSuccess:(NSDictionary*)result{
    
    NSString* mtc_id = @"";
    NSString* sid = @"";
    
    if( result[@"id"] != nil ){
        mtc_id = result[@"id"];
        [PAM defaultTrackingData].mtc_id = mtc_id;
        
         if( PAM.debugMode ){
             NSLog(@"PAM >>> Set mtc_id = %@" ,mtc_id );
         }
        
    }
    
    if( result[@"sid"] != nil ){
        sid = result[@"sid"];
        [PAM defaultTrackingData].sid = sid;
    }
    
    [[PAMLocalDataBase getInstance] saveMtcID:mtc_id sid:sid];
}

-(void)postTo:(NSString*)urlString data:(NSDictionary*)data{
    
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *postParams = [self postStringFromDictionary: data];
    
    NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *responseData, NSURLResponse *response, NSError *error) {
        
         if( PAM.debugMode ){
             NSString* newStr = [NSString stringWithUTF8String:[responseData bytes]];
             NSLog(@"PAM >>> Track Complete : %@",newStr);
         }
        
        if(error != nil ){
             if( PAM.debugMode ){
                 NSLog(@"%@", error.localizedDescription );
             }
            return;
        }
        
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonError == nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self onTrackingSuccess:json];
            });
        }
    }];
    
    [dataTask resume];
}


-(NSString*)postStringFromDictionary:(NSDictionary*)dictionary{
    if(dictionary == nil)return @"";
    
    NSMutableString *postString = [NSMutableString stringWithString:@""];
    
    NSArray *allKeys = dictionary.allKeys;
    for(int i=0; i<allKeys.count; i++){
        NSString *k = allKeys[i];
        NSString *v = dictionary[k];
        [postString appendString:[NSString stringWithFormat:@"%@=%@",k,v]];
        if(i < allKeys.count-1 ){
            [postString appendString:@"&"];
        }
    }
    
    return postString;
}

@end
