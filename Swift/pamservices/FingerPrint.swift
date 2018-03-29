//
//  FingerPrint.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

class FingerPrint {
    class func from(_ string: String) -> String? {
        return SHA1.hexString(from: string)
    }
}
