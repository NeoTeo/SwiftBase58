//
//  SwiftHexTests.swift
//  SwiftHexTests
//
//  Created by Teo on 20/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Cocoa
import XCTest

@testable import SwiftHex

class SwiftHexTests: XCTestCase {
    
    func testHexDecode() {
        
        let testDecoder = { (hexString: String, hexBytes: [UInt8]) throws -> () in
            let decStr = try SwiftHex.decodeString(hexString)
            XCTAssert(decStr == hexBytes)
        }
        
        do {
            try testDecoder("047f0000011104d2",[4,127,0,0,1,17,4,210])
            try testDecoder("047f0000010610e1",[4,127,0,0,1,6,16,225])
            try testDecoder("047f0000011104d2047f0000010610e1",[4,127,0,0,1,17,4,210,4,127,0,0,1,6,16,225])
        } catch {
            XCTFail()
        }
    }
    
    func testHexEncode() {
        
        let testEncoder = { (hexString: String, hexBytes: [UInt8]) -> () in
            let encStr = SwiftHex.encodeToString(hexBytes)
            XCTAssert(encStr == hexString)
        }
        
        testEncoder("047f0000011104d2",[4,127,0,0,1,17,4,210])
        testEncoder("047f0000010610e1",[4,127,0,0,1,6,16,225])
        testEncoder("047f0000011104d2047f0000010610e1",[4,127,0,0,1,17,4,210,4,127,0,0,1,6,16,225])
        
    }
}
