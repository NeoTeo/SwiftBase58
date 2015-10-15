//
//  SwiftBase58.swift
//  SwiftBase58
//
//  Created by Teo on 19/05/15.
//  Copyright (c) 2015 Teo. All rights reserved.
//
//  Licensed under MIT See LICENCE file in the root of this project for details. 

import Foundation
import SwiftGMP

let BTCAlphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"


let bigRadix = IntBig(58)
let bigZero = IntBig(0)

public func decode(b: String) -> [uint8] {
    return decodeAlphabet(b, alphabet: BTCAlphabet)
}

public func encode(b: [uint8]) -> String {
    return encodeAlphabet(b, alphabet: BTCAlphabet)
}

func decodeAlphabet(b: String, alphabet: String) -> [uint8] {
    var answer = IntBig(0)
    var j = IntBig(1)

    for ch in Array(b.characters.reverse()) {
        // Find the index of the letter ch in the alphabet.
        if let charRange = alphabet.rangeOfString(String(ch)) {
            let letterIndex = alphabet.startIndex.distanceTo(charRange.startIndex)
            let idx = IntBig(letterIndex)
            var tmp1 = IntBig(0)
            
            tmp1 = SwiftGMP.mul(j, idx)
            
            answer = SwiftGMP.add(answer, tmp1)
            //FIXME: Change calls to IntBig to be functions, not methods.
            j = SwiftGMP.mul(j, bigRadix)
        } else {
            
            return []
        }
    }
    
    /// Remove leading 1's
    // Find the first character that isn't 1
    let bArr = Array(b.characters)
    let zChar = Array(alphabet.characters)[0]
    var nz = 0
    for nz = 0 ; nz < b.characters.count ; nz++ {
        if bArr[nz] != zChar { break }
    }
    
    let tmpval = SwiftGMP.bytes(answer)
    var val = [uint8](count: nz, repeatedValue: 0)
    val += tmpval

    return val
}

func encodeAlphabet(byteSlice: [uint8], alphabet: String) -> String {
    var bytesAsIntBig = IntBig(byteSlice)
    let byteAlphabet = [uint8](alphabet.utf8)
    
    var answer = [uint8]()//(count: byteSlice.count*136/100, repeatedValue: 0)
    
    while SwiftGMP.cmp(bytesAsIntBig, bigZero) > 0 {
        let mod = IntBig()
        let (quotient, modulus) = SwiftGMP.divMod(bytesAsIntBig, bigRadix, mod)
        
        bytesAsIntBig = quotient
        
        // Make the String into an array of characters.
        answer.insert(byteAlphabet[SwiftGMP.getInt64(modulus)!], atIndex: 0)
    }
    
    // leading zero bytes
    for ch in byteSlice {
        if ch != 0 { break }
        answer.insert(byteAlphabet[0], atIndex: 0)
    }
    
    return String(bytes: answer, encoding: NSUTF8StringEncoding)!
}
