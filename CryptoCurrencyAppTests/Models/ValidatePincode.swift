//
//  ValidatePincode.swift
//  CryptoCurrencyAppTests
//
//  Created by IT-EFW-65-03 on 22/6/2566 BE.
//

import Foundation

class ValidatePincode {
    
    func isMoreSix(_ pincode: String) -> Bool {
        if pincode.count < 6 {
            return false
        }
        
        return true
    }
    
    func isDupLessTwo(_ pincode: String) -> Bool {
        var temp : Character?
        var count = 0
        for char in pincode {
            if char == temp {
                count += 1
            }else{
                count = 0
            }
            
            temp = char
            
            if count >= 2 {
                return false
            }
        }
        
        return true
    }
    
    func isNotSort(_ pincode: String) -> Bool {
        var temp : Int?
        var count = 0
        for char in pincode {
            let char_int = char.wholeNumberValue
            
            if ((char_int ?? 0) - 1) == temp  {
                count += 1
            }else if ((char_int ?? 0) + 1) == temp  {
                count += 1
            }else{
                count = 0
            }
            
            temp = char_int
            
            if count >= 2 {
                return false
            }
        }
        
        return true
    }
    
    func isNotCoupleDuplicate(_ pincode: String) -> Bool {
        var temp : Character?
        var count_dup = 0
        var count_double = 0
        for char in pincode {
            if char == temp {
                count_dup += 1
            }else{
                count_dup = 0
            }
            
            temp = char
            
            if count_dup >= 1 {
                count_double += 1
            }
            
            if count_double > 2 {
                return false
            }
        }
        
        return true
    }
}
