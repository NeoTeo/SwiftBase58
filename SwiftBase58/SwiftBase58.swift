//
//  SwiftBase58.swift
//  SwiftBase58
//
//  Created by Teo on 19/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//

import Foundation
import SwiftGMP

let BTCAlphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
let FlickrAlphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"

let bigRadix = IntBig(x: 58)
let bigZero = IntBig(x: 0)

public func decode(b: String) -> [uint8] {
    return decodeAlphabet(b, BTCAlphabet)
}

public func encode(b: [uint8]) -> String {
    return encodeAlphabet(b, BTCAlphabet)
}

func decodeAlphabet(b: String, alphabet: String) -> [uint8] {
    var answer = IntBig(x: 0)
    var j = IntBig(x: 1)

    for ch in reverse(b) {
        let tmp: Int = String.indexAny(alphabet, chars: String(ch))

        if tmp == -1 {
            return []
        }
        
        let idx = IntBig(x: tmp)
        var tmp1 = IntBig(x: 0)
        tmp1 = tmp1.mul(j, y: idx)
        
        answer = answer.add(answer, y: tmp1)
        j.mul(j, y: bigRadix)
    }
    
    /// Remove leading 1's
    // Find the first character that isn't 1
    let bArr = Array(b)
    let zChar = Array(alphabet)[0]
    var nz = 0
    for nz = 0 ; nz < count(b) ; nz++ {
        if bArr[nz] != zChar { break }
    }
    
    let tmpval = answer.bytes()
    var val = [uint8](count: nz, repeatedValue: 0)
    val += tmpval

    return val
}

func encodeAlphabet(b: [uint8], alphabet: String) -> String {
        return "hola"
}


extension String {
    
    static func indexAny(s: String, chars: String) -> String.Index? {
        if count(chars) > 0 {
            for i in indices(s) {
                for m in chars {
                    if s[i] == m {
                        return i
                    }
                }
            }
        }
        return nil
    }
    
    static func indexAny(s: String, chars: String) -> Int {
        if count(chars) > 0 {
            for var i = 0 ; i < count(s) ; i++ {
                for m in chars {
                    if Array(s)[i] == m {
                        return i
                    }
                }
            }
        }
        return -1
    }
}