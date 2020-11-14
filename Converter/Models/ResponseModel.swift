//
//  ResponseModel.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import Foundation

// MARK: - Welcome
struct ResponseModel:Decodable {
    let Valute: [String: Valute]
}

// MARK: - Valute
struct Valute:Decodable {
    let CharCode: String
    let Name: String
    let Value: Double
    let Nominal: Int
}
