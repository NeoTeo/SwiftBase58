//
//  SwiftBase58Tests.swift
//  SwiftBase58Tests
//
//  Created by Teo on 19/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Cocoa
import XCTest
import SwiftBase58
import SwiftHex

let stringTests = [
    ("", ""),
    (" ", "Z"),
    ("-", "n"),
    ("0", "q"),
    ("1", "r"),
    ("-1", "4SU"),
    ("11", "4k8"),
    ("abc", "ZiCa"),
    ("1234598760", "3mJr7AoUXx2Wqd"),
    ("abcdefghijklmnopqrstuvwxyz", "3yxU3u1igY8WkgtjK92fbJQCd4BZiiT1v25f"),
    ("00000000000000000000000000000000000000000000000000000000000000", "3sN2THZeE9Eh9eYrwkvZqNstbHGvrxSAM7gXUXvyFQP8XvQLUqNCS27icwUeDT7ckHm4FUHM2mTVh1vbLmk7y")
]

let invalidStringTests = [
    ("0", ""),
    ("O", ""),
    ("I", ""),
    ("l", ""),
    ("3mJr0", ""),
    ("O3yxU", ""),
    ("3sNI", ""),
    ("4kl8", ""),
    ("0OIl", ""),
    ("!@#$%^&*()-_=+~`", "")
]

let hexTests = [
//    ("61", "2g"),
//    ("626262", "a3gV"),
//    ("636363", "aPEr"),
    ("73696d706c792061206c6f6e6720737472696e67", "2cFupjhnEsSn59qHXstmK2ffpLv2"),
    ("00eb15231dfceb60925886b67d065299925915aeb172c06647", "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L"),
    ("516b6fcd0f", "ABnLTmg"),
    ("bf4f89001e670274dd", "3SEo3LWLoPntC"),
    ("572e4794", "3EFU7m"),
    ("ecac89cad93923c02321", "EJDM8drfXA6uyA"),
    ("10c8511e", "Rt5zm"),
    ("00000000000000000000", "1111111111"),
]


class SwiftBase58Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncodeBase58() {

        for (testNum, (inString, outString)) in enumerate(stringTests) {
        
            let byteStr = [uint8](inString.utf8)
            let result = SwiftBase58.encode(byteStr)
            
            XCTAssertEqual(result, outString, "Base58Encode test #\(testNum+1) failed! Got: \(result) Want: \(outString)")
        }
    }
    
    func testDecodeBase58() {
        for (testNum, (inString, outString)) in enumerate(hexTests) {
            
            if let stringBuf = SwiftHex.decodeString(inString) {
            
                let result = SwiftBase58.decode(outString)
                XCTAssertEqual(result, stringBuf, "Base58Decode test #\(testNum+1) failed! Got: \(result) wanted: \(inString)")
            } else {
                XCTAssert(false, "SwiftHex.decodeString failed test#\(testNum+1)")
            }
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let d = decode("Arsenator")
        println("decode = \(d)")
        let dat: [uint8] = [49,50,51,52,53,57,56,55,54,48]
        let e = SwiftBase58.encode(dat)
        println("encode = \(e)")
        XCTAssert(true, "Pass")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
