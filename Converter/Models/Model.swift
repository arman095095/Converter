//
//  Model.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import Foundation

protocol Currency {
    var value: String { get }
    var name: String { get }
    var description: String { get }
    var nominal: Int { get }
}

protocol CurrencyModelType {
    var name: String { get }
    var description: String { get }
    var selected: Bool { set get }
}


struct CurrencyModel: Currency, CurrencyModelType {
    
    var selected: Bool = false
    var value: String
    var name: String
    var description: String
    var nominal: Int
    
    static func getDictModels(from dict:[String:Valute]) -> [String:CurrencyModel] {
        var currencyModels = [String:CurrencyModel]()
        for (key,valute) in dict {
            let model = CurrencyModel(valute: valute)
            currencyModels[key] = model
        }
        currencyModels["RU"] = CurrencyModel(value: "1", name: "RU", description: "Российский рубль",nominal : 1)
        return currencyModels
    }
}

extension CurrencyModel {
    init(valute: Valute) {
        self.init(value: String(valute.Value), name: valute.CharCode, description: valute.Name,nominal : valute.Nominal)
    }
}
