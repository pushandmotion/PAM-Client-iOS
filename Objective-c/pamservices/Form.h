//
//  Form.h
//  pamservices
//
//  Created by narongrit kanhanoi on 17/5/2561 BE.
//  Copyright © 2561 heart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Form : NSObject

@property(nonatomic,strong)NSString* formId;
@property(nonatomic,strong)NSMutableDictionary* formData;

+(Form*)formWithFormId:(NSString*)formId;

-(void)addFieldName:(NSString*)name value:(NSString*)value;
-(NSDictionary*)getFormDataAsDictionary;

@end
