//
//  SwiftGMP.swift
//  SwiftGMP
//
//  Created by Teo on 21/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Foundation
import GMP

/// Multiple-precision Integer
public struct IntBig {
    var i: mpz_t
    var inited: Bool

    public init() {
        i = mpz_t()
        __gmpz_init(&i)
        inited = true
    }
    
    public init(x: Int) {
        self.init()
        setInt64(x)
    }
}

extension IntBig {

    func _Int_finalize(inout z: IntBig) {
        if z.inited {
            __gmpz_clear(&z.i)
        }
    }

    // Done by the struct init
//    func doInit(inout z: IntBig) {
//
//        if z.inited { return }
//        z.inited = true
//        __gmpz_init(&z.i)
//    }
    
    func clear(inout z: IntBig) {
        _Int_finalize(&z)
    }
    
    func sign() -> Int {
        if self.i._mp_size < 0 {
            return -1
        } else {
            return Int(self.i._mp_size)
        }
    }

    mutating func setInt64(x: Swift.Int) -> IntBig {
        let y = CLong(x)
        if Int(y) == x {
            __gmpz_set_si(&i, y)
        } else {
            var negative = false
            var nx = x
            if x < 0 {
                nx = -x
                negative = true
            }

            __gmpz_import(&i, 1, 0, 8, 0, 0, &nx)
            if negative {
                __gmpz_neg(&i, &i)
            }
        }
        return self
    }
    
//    public func newIntBig(x: Swift.Int) -> IntBig {
//        var newInt = IntBig()
//        return newInt.setInt64(x)
//    }
    
//    public mutating func add(inout x: IntBig, inout y: IntBig) -> IntBig {
public func add(x: IntBig, y: IntBig) -> IntBig {
        var a = x
        var b = y
        var c = self
        __gmpz_add(&c.i, &a.i, &b.i)

//        __gmpz_add(&i, &x.i, &y.i)
        return c
    }
    
    public func sub(x: IntBig, y: IntBig) -> IntBig {
        var a = x
        var b = y
        var c = self
        __gmpz_sub(&c.i, &a.i, &b.i)
        return c
    }
    
    public func mul(x: IntBig, y: IntBig) -> IntBig {
        var a = x
        var b = y
        var c = self
        __gmpz_mul(&c.i, &a.i, &b.i)
        return c
    }
    
    func inBase(base: Int) -> String {
        var ti = i
        let p = __gmpz_get_str(nil, CInt(base), &ti)
        let s = String.fromCString(p)
        return s!
    }
    
    public func string() -> String {
        return inBase(10)
    }
    
    public func bytes() -> [uint8] {
        var c = self
        let size = 1 + ((bitLen() + 7) / 8)
        var b = [uint8](count: size, repeatedValue: uint8(0))
        var n = size_t(count(b))
        __gmpz_export(&b, &n, 1, 1, 1, 0, &c.i)
        
        return Array(b[0..<n])
    }

    func bitLen() -> Int {
        if self.sign() == 0 {
            return 0
        }
        var c = self
        return Int(__gmpz_sizeinbase(&c.i, 2))
    }
}