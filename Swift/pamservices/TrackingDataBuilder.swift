//
//  TrackingDataBuilder.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

import UIKit

class TrackingDataBuilder {
    
    var page_title:String
    var page_language:String
    var page_referrer:String
    var page_url:String
    var resolution:String
    var updfh:String
    var appId:String
    var mtc_id:String
    var sid:String
    var counter:Number
    
    
    func build() -> TrackingData {
        let data = TrackingData()
        data.page_title = page_title
        data.page_referrer = page_referrer
        data.page_url = page_url
        data.counter = counter
        data.appId = appId
        data.mtc_id = mtc_id
        data.sid = sid
        if updfh != nil {
            data.updfh = updfh
        }
        if resolution == nil {
            setResolutionExactAsDeviceScreen()
        }
        data.resolution = resolution
        if page_language == nil {
            setPageLanguageFromDeviceConfiguarion()
        }
        data.page_language = page_language
        data.timezone_offset = getTimezoneOffset()
        return data
    }
    
    func clone() -> TrackingDataBuilder {
        let builder = TrackingDataBuilder()
        builder.appId = appId
        builder.mtc_id = mtc_id
        builder.updfh = updfh
        builder.page_title = page_title
        builder.page_language = page_language
        builder.page_referrer = page_referrer
        builder.page_url = page_url
        builder.counter = counter
        builder.resolution = resolution
        builder.sid = sid
        return builder
    }
    
    func setPageLanguageFromDeviceConfiguarion() {
        page_language = NSLocale.preferredLanguages.first
    }
    
    func setResolutionFrom(_ res: String) {
        resolution = res
    }
    
    func setResolutionFromWidth(_ w: Int, height h: Int) {
        resolution = "\(w)\(h)"
    }
    
    func setResolutionExactAsDeviceScreen() {
        let w: Int = UIScreen.main.bounds.size.width
        let h: Int = UIScreen.main.bounds.size.height
        resolution = "\(w)\(h)"
    }
    
    func getTimezoneOffset() -> NSNumber {
        let millisecondsFromGMT: Int = NSTimeZone.local.secondsFromGMT / 60
        return (millisecondsFromGMT * -1)
    }
}
