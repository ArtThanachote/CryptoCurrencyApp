//
//  ApiRouter.swift
//  demoFirebase
//
//  Created by IT-EFW-65-03 on 3/11/2565 BE.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    case Get
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: url)        
        var urlRequest = URLRequest(url: url!)
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        switch self {
        case .Get:
            return try encoding.encode(urlRequest, with: nil)
        }
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .Get:
            return .get
        }
    }
    
    
    //MARK: - Url
    //The path is the part following the base url
    private var url: String {
        switch self {
        case .Get:
            return Constants.baseUrl
        }
    }
}
