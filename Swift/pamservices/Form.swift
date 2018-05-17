//
//  Form.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 17/5/2561 BE.
//

import Foundation

public class Form{
    var formId:String?
    var formData:Dictionary<String,String>?
    
    init() {
        self.formData = Dictionary<String,String>()
    }
    
    public class func createFormWithFormId(formId:String) -> Form {
        let form = Form()
        form.formId = formId;
        form.formData?["formId"] = formId;
        return form
    }
    
    public func addField(name:String ,value:String){
        self.formData?[name] = value;
    }
    
    
}
