//
//  SwiftGMPTests.swift
//  SwiftGMPTests
//
//  Created by Teo on 21/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Cocoa
import XCTest
import SwiftGMP

class SwiftGMPTests: XCTestCase {
    
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
        var b = IntBig(x: 246375425603637729)//.newIntBig(58)
        var c = IntBig(x: 58)

        println("Bytes: \(b.bytes())")
        
        var d = b.mul(b, y: c)
        println("mul: \(d.string())")
        
        d = b.add(b, y: c)
        println("add: \(d.string())")
        
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
