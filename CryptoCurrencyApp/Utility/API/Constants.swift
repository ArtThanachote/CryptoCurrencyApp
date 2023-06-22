//
//  Constants.swift
//  demoFirebase
//
//  Created by IT-EFW-65-03 on 3/11/2565 BE.
//

import Foundation
import UIKit

struct Constants {
    //The API's base URL
    static let baseUrl = "https://api.coindesk.com/v1/bpi/currentprice.json"

    //The header fields
    enum HttpHeaderField: String {
        case contentType = "Content-Type"
        case acceptType = "Accept"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json
        
        var rawValue: String {
            get {
                switch self {
                case .json:
                    return "application/json"
                }
            }
        }
    }
}

enum Currency {
    case USD, GBP, EUR
}
