//
//  PAMClient.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

class PAMClient {
    
    var pamUrl:String?
    
    func trackPageView(_ data: TrackingData, customFields:Dictionary<String,String>?=nil) {
        var dict: [AnyHashable: Any] = data.toDictionary()
        
        if let f = customFields{
            for (k, v) in f {
                dict[k] = v;
            }
        }
        
        let url: String = createEventURL("rest/event")
        post(to: url, data: dict)
    }
    
    
    
    func createEventURL(_ subfix: String) -> String {
        if pamUrl?.suffix(1) == "/" {
            return "\(pamUrl!)\(subfix)"
        }
        return "\(pamUrl!)/\(subfix)"
    }
    
    func onTrackingSuccess(_ result: [AnyHashable: Any]) {
        var mtc_id: String = ""
        var sid: String = ""
        if result["id"] != nil {
            mtc_id = result["id"] as! String
            PAM.defaultTrackingData().mtc_id = mtc_id
        }
        if result["sid"] != nil {
            sid = result["sid"] as! String
            PAM.defaultTrackingData().sid = sid
        }
        PAMLocalDataBase.getInstance().saveMtcID(mtc_id, sid: sid)
    }
    
    func post(to urlString: String, data: [AnyHashable: Any]) {
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)

        var urlRequest = URLRequest(url: URL(string: urlString)! )
        let postParams = postString(fromDictionary: data)
        let postData: Data? = postParams.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
        
        defaultSession.dataTask(with:urlRequest, completionHandler: { ( data, response, error) ->Void in
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : AnyObject]
            self.onTrackingSuccess(json!)
            
        }).resume()
        
    }
   
    func postString(fromDictionary dict: [AnyHashable: Any]) -> String {
        var postString: String = ""
        for (k, v) in dict {
            postString += "\(k)=\(v)&"
        }
        return String(postString.prefix(postString.count-1))
    }
}





