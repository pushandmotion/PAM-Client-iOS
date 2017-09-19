//
//  PAM.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

class PAM {
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
    
    class func trackUpdfh(_ updfh: String) {
        PAMLocalDataBase.getInstance().saveUPDFH(updfh)
        self.defaultTrackingData().updfh = updfh
        self.trackPageView(withPagename: "updfh")
    }
    
    class func trackPageView(withPagename pageName: String, data: TrackingData) {
        data.page_title = pageName
        self.defaultPAMClient().trackPageView(data)
    }
    
    class func trackPageView(withPagename pageName: String) {
        let builder: TrackingDataBuilder? = self.createTackingDataBuilder()
        builder?.page_title = pageName
        self.defaultPAMClient().trackPageView(builder?.build())
    }
    
    class func trackPageView(with data: TrackingData) {
        self.defaultPAMClient().trackPageView(data)
    }
    
    class func init(_ pamUrl: String, appId: String) {
        let defaultData: TrackingDataBuilder? = self.defaultTrackingData()
        defaultData?.appId = appId
        defaultData?.counter = 0
        let updfh: String = PAMLocalDataBase.getInstance().getUPDFH()
        let mtc_id: String = PAMLocalDataBase.getInstance().getMtcID()
        let sid: String = PAMLocalDataBase.getInstance().getSID()
        if updfh != nil && !(updfh == "") {
            defaultData?.updfh = updfh
        }
        if mtc_id != nil && !(mtc_id == "") {
            defaultData?.mtc_id = mtc_id
        }
        if sid != nil && !(sid == "") {
            defaultData?.sid = sid
        }
        self.defaultPAMClient().pamUrl = pamUrl
    }
    
    class func defaultPAMClient() -> PAMClient {
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
