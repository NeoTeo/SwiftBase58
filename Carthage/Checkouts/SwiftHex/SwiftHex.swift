//
//  SwiftHex.swift
//  SwiftHex
//
//  Adapted from code from Stack Overflow.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Foundation

public func encodeToString(hexBytes: [uint8]) -> String {
    var outString = ""
    for val in hexBytes {
        // Prefix with 0 for values less than 16.
        if val < 16 { outString += "0" }
        outString += String(val, radix: 16)
    }
    return outString
}

private func trimString(theString: String) -> String? {
    let trimmedString = theString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<> ")).stringByReplacingOccurrencesOfString(" ", withString: "")
    
    // Clean up string to remove non-hex digits.
    // Ensure there is an even number of digits.
    var error: NSError?
    let regex = NSRegularExpression(pattern: "^[0-9a-f]*$", options: .CaseInsensitive, error: &error)
    let found = regex?.firstMatchInString(trimmedString, options: nil, range: NSMakeRange(0, count(trimmedString)))
    
    if found == nil || found?.range.location == NSNotFound || count(trimmedString) % 2 != 0 {
        return nil
    }
    
    return trimmedString
}

public func decodeString(hexString: String) -> [uint8]? {
    
    if let data = NSMutableData(capacity: count(hexString) / 2) {
        
        for var index = hexString.startIndex; index < hexString.endIndex; index = index.successor().successor() {
            let byteString = hexString.substringWithRange(Range<String.Index>(start: index, end: index.successor().successor()))
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16)})
            data.appendBytes([num] as [UInt8], length: 1)
        }
        var outBuf = [uint8](count: data.length, repeatedValue: 0x0)
        data.getBytes(&outBuf, length: data.length)
        
        return outBuf
    }
    return nil
}
