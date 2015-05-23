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
//import SwiftGMP

class SwiftBase58Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let d = decode("Arsenator")
        println("decode = \(d)")

        XCTAssert(true, "Pass")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
