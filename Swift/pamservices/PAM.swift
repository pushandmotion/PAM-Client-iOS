//
//  PAM.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

public class PAM {
    class func defaultTrackingData() -> TrackingDataBuilder {
        var defaultData: TrackingDataBuilder? = nil
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if defaultData == nil {
                defaultData = TrackingDataBuilder()
            }
        }
        return defaultData!
    }
    
    class func createTackingDataBuilder() -> TrackingDataBuilder {
        return self.defaultTrackingData().clone()
    }
    
    public class func trackUpdfh(_ updfh: String) {
        PAMLocalDataBase.getInstance().saveUPDFH(updfh)
        self.defaultTrackingData().updfh = updfh
        self.trackPageView(withPagename: "updfh")
    }
    
    class public func trackPageView(withPagename pageName: String, data: TrackingData) {
        data.page_title = pageName
        self.defaultPAMClient().trackPageView(data)
    }
    
    public class func trackPageView(withPagename pageName: String) {
        let builder: TrackingDataBuilder? = self.createTackingDataBuilder()
        builder?.page_title = pageName
        self.defaultPAMClient().trackPageView(builder!.build())
    }
    
    public class func trackPageView(with data: TrackingData) {
        self.defaultPAMClient().trackPageView(data)
    }
    
    public class func trackCustomField(cuttomFields:Dictionary<String,String>){
        let builder: TrackingDataBuilder? = self.createTackingDataBuilder()
        builder?.page_title = "cuttomFields"
        self.defaultPAMClient().trackPageView(builder!.build(), customFields: cuttomFields)
    }
    
    public class func initPam(_ pamUrl: String, appId: String) {
        let defaultData: TrackingDataBuilder? = self.defaultTrackingData()
        defaultData?.appId = appId
        defaultData?.counter = 0
        
        let updfh = PAMLocalDataBase.getInstance().getUPDFH()
        let mtc_id = PAMLocalDataBase.getInstance().getMtcID()
        
        let sid: String = PAMLocalDataBase.getInstance().getSID()
        if updfh != "" {
            defaultData?.updfh = updfh
        }
        if mtc_id != "" {
            defaultData?.mtc_id = mtc_id
        }
        if sid != "" {
            defaultData?.sid = sid
        }
        self.defaultPAMClient().pamUrl = pamUrl
    }
    
    public class func defaultPAMClient() -> PAMClient {
        var pam: PAMClient? = nil
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if pam == nil {
                pam = PAMClient()
            }
        }
        return pam!
    }
}
