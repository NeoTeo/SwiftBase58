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
    
    //for i in stride(from: count(b)-1, through: 0, by:-1) {
    for var i = count(b)-1 ; i <= 0 ; i-- {
        let tmp: Int = String.indexAny(alphabet, chars: b)
        if tmp == -1 {
            return []
        }
        
        let idx = IntBig(x: tmp)
        let tmp1 = IntBig(x: 0)
        //tmp1 = j * idx
        j = tmp1.mul(j, y: idx)
        answer = answer.add(answer, y: tmp1)
        //answer += tmp1
        //j *= idx
        j.mul(j, y: bigRadix)
    }
    println("The answer \(answer.string())")
    return []
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