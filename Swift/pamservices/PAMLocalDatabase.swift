//
//  PAMLocalDataBase.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

let DB_NAME = "pam.sqlite"
class PAMLocalDataBase {
    class func getInstance() -> PAMLocalDataBase {
        var sharedInstance: PAMLocalDataBase? = nil
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if sharedInstance == nil {
                sharedInstance = self.init()
            }
        }
        return sharedInstance!
    }
    
    init() {
        super.init()
        
        
        
        return nil
    }
    
    func saveMtcID(_ mtc_id: String, sid: String) {
        let defaults = UserDefaults.standard
        defaults.set(mtc_id, forKey: "mtc_id")
        defaults.set(sid, forKey: "sid")
        defaults.synchronize()
    }
    
    func saveUPDFH(_ updfh: String) {
        let defaults = UserDefaults.standard
        defaults.set(updfh, forKey: "updfh")
        defaults.synchronize()
    }
    
    func getMtcID() -> String {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "mtc_id")!
    }
    
    func getSID() -> String {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "sid")!
    }
    
    func getUPDFH() -> String {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "updfh")!
    }
}
