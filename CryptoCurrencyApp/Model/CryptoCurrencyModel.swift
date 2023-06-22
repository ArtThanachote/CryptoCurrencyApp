//
//  CryptoCurrencyModel.swift
//  CryptoCurrencyApp
//
//  Created by IT-EFW-65-03 on 21/6/2566 BE.
//

import Foundation

// MARK: - CryptoCurrencyModel
struct CryptoCurrencyModel: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Eur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let code, symbol, rate, description: String
    let rate_float: Double
}

// MARK: - Time
struct Time: Codable {
    //    let updated: String
    let updatedISO: String
    //    let updateduk: String
}

struct TempModel: Codable {
    let time: Time?
    let bpi : Bpi?
}

struct Display: Codable {
    let time: Time?
    let eur : Eur?
}
