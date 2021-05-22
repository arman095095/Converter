//
//  MainCurrencyViewModel.swift
//  Converter
//
//  Created by Arman Davidoff on 30.10.2020.
//

import Foundation

protocol MainCurrencyViewModelProtocol {
    
    init(models: [String:Currency],selectedLeft: Currency,selectedRight: Currency, leftValue: String, rightValue: String)
    var selectedLeft: Currency { set get }
    var selectedRight: Currency { set get }
    var leftValue: String { set get }
    var rightValue: String { set get }
    
    func getModels() -> [String:Currency]
    func calculateForRight(nominal:String) -> String
    func calculateForLeft(nominal:String) -> String
    
    var selectingBind: ((MainCurrencyViewModel) -> ())? { set get }
    var changeValueBindForLeft: ((String) -> ())? { set get }
    var changeValueBindForRight: ((String) -> ())? { set get }
}

class MainCurrencyViewModel: MainCurrencyViewModelProtocol {
    
    private var models: [String:Currency]
    
    var selectedLeft: Currency {
        didSet {
            selectingBind?(self)
        }
    }
    var selectedRight: Currency {
        didSet {
            selectingBind?(self)
        }
    }
    var leftValue: String {
        didSet {
            let value = calculateForRight(nominal: leftValue)
            changeValueBindForLeft?(value)
        }
    }
    var rightValue: String {
        didSet {
            let value = calculateForLeft(nominal: rightValue)
            changeValueBindForRight?(value)
        }
    }
    
    var selectingBind: ((MainCurrencyViewModel) -> ())? {
        didSet {
            selectingBind?(self)
        }
    }
    
    var changeValueBindForLeft: ((String) -> ())? {
        didSet {
            let value = calculateForRight(nominal: leftValue)
            changeValueBindForLeft?(value)
        }
    }
    var changeValueBindForRight: ((String) -> ())?
    
    required init(models: [String: Currency], selectedLeft: Currency, selectedRight: Currency, leftValue: String, rightValue: String) {
        self.models = models
        self.selectedLeft = selectedLeft
        self.selectedRight = selectedRight
        self.leftValue = leftValue
        self.rightValue = rightValue
    }
    
    func getModels() -> [String: Currency] {
        return models
    }
    
    private func calculate(x: Currency, y: Currency, nominal: String) -> String {
        guard let X = Double(x.value) else { return "ошибка" }
        guard let Y = Double(y.value) else { return "ошибка" }
        guard let nominal = Double(nominal) else { return "ошибка" }
        let result = (X / Y) * nominal * (Double(y.nominal)) / (Double(x.nominal))
        
        return String(format: "%.3f",result)
    }
    
    func calculateForRight(nominal: String) -> String {
        return calculate(x: selectedLeft, y: selectedRight, nominal: nominal)
    }
    
    func calculateForLeft(nominal: String) -> String {
        return calculate(x: selectedRight, y: selectedLeft, nominal: nominal)
    }
}
