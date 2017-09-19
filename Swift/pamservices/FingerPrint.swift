//
//  FingerPrint.swift
//  pamservices
//
//  Created by narongrit kanhanoi on 9/8/2560 BE.
//  Copyright © 2017 pushandmotion.com. All rights reserved.
//

import CommonCrypto

class FingerPrint {
    class func from(_ string: String) -> String {
        let data: Data? = string.data(using: String.Encoding.utf8)
        let digest = [UInt8](repeating: 0, count: CC_SHA1_DIGEST_LENGTH)
        CC_SHA1(data?.bytes, (data?.count as? CC_LONG), digest)
        var output = String(capacity: CC_SHA1_DIGEST_LENGTH * 2)
        for i in 0..<CC_SHA1_DIGEST_LENGTH {
            output += String(format: "%02x", digest[i])
        }
        return output
    }
}
