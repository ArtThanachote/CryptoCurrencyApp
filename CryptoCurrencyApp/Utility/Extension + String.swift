//
//  Extension + String.swift
//  CryptoCurrencyApp
//
//  Created by IT-EFW-65-03 on 22/6/2566 BE.
//

import Foundation

extension String {
    func convertSymbols() -> String{
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}
