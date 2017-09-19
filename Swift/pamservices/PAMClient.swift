//
//  PAMClient.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

class PAMClient {
    func trackPageView(_ data: TrackingData) {
        let dict: [AnyHashable: Any] = data.toDictionary()
        let url: String = createEventURL("rest/event")
        post(to: url, data: dict)
    }
    
    func createEventURL(_ subfix: String) -> String {
        if ((pamUrl as? NSString)?.substring(from: pamUrl.length - 1) == "/") {
            return "\(pamUrl)\(subfix)"
        }
        return "\(pamUrl)/\(subfix)"
    }
    
    func onTrackingSuccess(_ result: [AnyHashable: Any]) {
        var mtc_id: String = ""
        var sid: String = ""
        if result["id"] != nil {
            mtc_id = result["id"]
            PAM.defaultTrackingData().mtc_id = mtc_id
        }
        if result["sid"] != nil {
            sid = result["sid"]
            PAM.defaultTrackingData().sid = sid
        }
        PAMLocalDataBase.getInstance().saveMtcID(mtc_id, sid: sid)
    }
    
    func post(to urlString: String, data: [AnyHashable: Any]) {
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        let url = URL(string: urlString)
        var urlRequest = NSMutableURLRequest(url: url!)
        let postParams = postString(fromDictionary: data)
        let postData: Data? = postParams.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
        let dataTask: URLSessionDataTask? = defaultSession.dataTask(with: urlRequest, completionHandler: {(_ responseData: Data, _ response: URLResponse, _ error: Error?) -> Void in
            if error != nil {
                print("\(error?.localizedDescription)")
                return
            }
            var jsonError: Error?
            let json: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(with: responseData, options: NSJSONReadingMutableContainers)
            if jsonError == nil {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.onTrackingSuccess(json)
                })
            }
        })
        dataTask?.resume()
    }
    
    func postString(fromDictionary dict: [AnyHashable: Any]) -> String {
        if dict == nil {
            return ""
        }
        var postString: String = ""
        let allKeys: [Any] = dict.keys
        for i in 0..<allKeys.count {
            let k: String
            let v: String
            postString += "\(k)=\(v)"
            if i < allKeys.count - 1 {
                postString += "&"
            }
        }
        return postString
    }
}
