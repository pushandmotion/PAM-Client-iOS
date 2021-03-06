//
//  TrackingData.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//


public class TrackingData {
    
    var page_title:String!
    var page_language:String!
    var page_referrer:String!
    var page_url:String!
    var resolution:String!
    var updfh:String!
    var appId:String!
    var mtc_id:String!
    var sid:String!
    var counter:Int!
    var timezone_offset:Int!
    var platform:String!
    var adblock:String!
    var do_not_track:String!
    
    init() {
        adblock = "false"
        do_not_track = "false"
    }
    
    public func getFingerPrint() -> String {
        var str: String = "\(updfh)\(appId)\(page_language)\(resolution)\(timezone_offset)\(platform)\(adblock)"
        if page_title != nil {
            str = str + (page_title)
        }
        if page_referrer != nil {
            str = str + (page_title)
        }
        if page_url != nil {
            str = str + (page_title)
        }
        if counter != nil {
            str = str + (page_title)
        }
        return FingerPrint.from(str)!
    }
    
    public func toDictionary() -> [AnyHashable : Any]! {
        var dict = [AnyHashable: Any]()
        dict["app_id"] = appId
        dict["page_language"] = page_language
        dict["resolution"] = resolution
        dict["timezone_offset"] = timezone_offset
        dict["platform"] = platform
        dict["do_not_track"] = do_not_track
        dict["adblock"] = "false"
        if updfh != nil {
            dict["updfh"] = updfh
        }
        if page_title != nil {
            dict["page_title"] = page_title
        }
        if page_referrer != nil {
            dict["page_referrer"] = page_referrer
        }
        if page_url != nil {
            dict["page_url"] = page_url
            PAM.defaultTrackingData().page_referrer = page_url
        }
        if counter != nil {
            dict["counter"] = counter
        }
        if mtc_id != nil {
            dict["mtc_id"] = mtc_id
        }
        if sid != nil {
            dict["sid"] = sid
        }
        dict["fingerprint"] = getFingerPrint()
        return dict
    }
}
