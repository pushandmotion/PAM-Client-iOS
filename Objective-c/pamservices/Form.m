//
//  Form.m
//  pamservices
//
//  Created by narongrit kanhanoi on 17/5/2561 BE.
//  Copyright © 2561 heart. All rights reserved.
//

#import "Form.h"

@implementation Form

+(Form*)formWithFormId:(NSString*)formId{
    Form *form = [[Form alloc] init];
    form.formId = formId;
    [form addFieldName:@"formId" value:formId];
    return form;
}

-(id)init{
    if(self = [super init]){
        self.formData = [NSMutableDictionary dictionary];
        return self;
    }
    return nil;
}

-(void)addFieldName:(NSString*)name value:(NSString*)value{
    [self.formData setObject:value forKey:name];
}

-(NSDictionary*)getFormDataAsDictionary{
    return [self.formData copy];
}

@end
