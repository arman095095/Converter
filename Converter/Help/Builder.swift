//
//  Bulder.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class Builder {
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func getMainVC(model: ResponseModel) -> MainViewController {
        let models = CurrencyModel.getDictModels(from: model.Valute)
        let usd = models["USD"]!
        let ru = models["RU"]!
        let viewModel: MainCurrencyViewModelProtocol = MainCurrencyViewModel(models: models, selectedLeft: usd, selectedRight: ru, leftValue: "1", rightValue: "1")
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel = viewModel
        return vc
    }
    
    static func getChangeCurrencyVC(delegate: ChangeCurrencyDelegate, type: ChangeType,models: [String: Currency],selectedItem: Currency) -> ChangeCurrencyViewController {
        
        let castedModels = (Array(models.values) as! Array<CurrencyModelType>)
        let castedSelectedItem = (selectedItem as! CurrencyModelType)
        let viewModel: ChangeCurrencyViewModelProtocol = ChangeCurrencyViewModel(changeSide: type, models: castedModels, selectedItem: castedSelectedItem)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "changeCurrencyVC") as! ChangeCurrencyViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = delegate
        vc.viewModel = viewModel
        
        return vc
        
    }
    
    
}
