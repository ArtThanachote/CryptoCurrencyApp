//
//  CryptoCurrencyAppTests.swift
//  CryptoCurrencyAppTests
//
//  Created by IT-EFW-65-03 on 21/6/2566 BE.
//

import XCTest
@testable import CryptoCurrencyApp

final class CryptoCurrencyAppTests: XCTestCase {

    let pincode : String = "887712"
    
    func test_pincode_count () {
        let validatePincode = ValidatePincode()
        let valid = validatePincode.isMoreSix(pincode)
        
        XCTAssertTrue(valid)
    }
    
    func test_duplicate_char_pincode () {
        let validatePincode = ValidatePincode()
        let valid = validatePincode.isDupLessTwo(pincode)
        
        XCTAssertTrue(valid)
    }
    
    func test_sort_char_pincode () {
        let validatePincode = ValidatePincode()
        let valid = validatePincode.isNotSort(pincode)
        
        XCTAssertTrue(valid)
    }
    
    func test_double_char_pincode () {
        let validatePincode = ValidatePincode()
        let valid = validatePincode.isDoubleDup(pincode)
        
        XCTAssertTrue(valid)
    }

}
