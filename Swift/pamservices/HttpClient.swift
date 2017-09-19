//
//  HttpClient.swift
//  pamservices
//
//  Created by heart on 8/23/2560 BE.
//
//

import Foundation

func makeGetCall( urlEndpoint:String, completion: @escaping (_ result: String?, _ error:Error?)->() ) {
    
    guard let url = URL(string: urlEndpoint) else {
        
        completion(nil,Error("cannot create URL"))
        return
    }
    
    let urlRequest = URLRequest(url: url)
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        
        if let e = error {
            print("error calling GET" , e.localizedDescription )
            return
        }
       
        if let responseData = data {
            if let r = String(data:responseData, encoding:.utf8) {
                completion(r,nil)
            }
        }
    }
    task.resume()
}

/*
func parseJson(data:Data)->Any{
    do {
        guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
            print("error trying to convert data to JSON")
            return
        }
        return json;
    } catch  {
        print("error trying to convert data to JSON")
        return nil;
    }
}
*/
