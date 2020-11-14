//
//  ChangeCurrencyViewModel.swift
//  Converter
//
//  Created by Arman Davidoff on 30.10.2020.
//

import Foundation

protocol ChangeCurrencyViewModelProtocol {
    init(changeSide: ChangeType, models: [CurrencyModelType], selectedItem: CurrencyModelType)
    
    var changeSide: ChangeType { get }
    var selectedItem: CurrencyModelType { get }
    
    func rowsCount() -> Int
    func itemForSend(for indexPath: IndexPath) -> Currency
    func getItem(for indexPath: IndexPath) -> CurrencyModelType
}

class ChangeCurrencyViewModel: ChangeCurrencyViewModelProtocol {
    
    required init(changeSide: ChangeType, models: [CurrencyModelType], selectedItem: CurrencyModelType) {
        self.models = models
        self.selectedItem = selectedItem
        self.changeSide = changeSide
    }
    
    private var models: [CurrencyModelType]
    var changeSide: ChangeType
    var selectedItem: CurrencyModelType
    
    func rowsCount() -> Int {
        return models.count
    }
    
    private func item(for indexPath: IndexPath) -> CurrencyModelType {
        return models[indexPath.row]
    }
    
    func itemForSend(for indexPath: IndexPath) -> Currency {
        return models[indexPath.row] as! Currency
    }
    
    func getItem(for indexPath: IndexPath) -> CurrencyModelType {
        var model = item(for: indexPath)
        model.selected = item(for: indexPath).name == self.selectedItem.name
        return model
    }
}
