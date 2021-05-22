//
//  LoadViewModel.swift
//  Converter
//
//  Created by Arman Davidoff on 22.05.2021.
//

import Foundation

class LoadViewModel {
    
    private var networkManager = NetworkManager()
    var complitionFailure: (() -> ())?
    var complitionSuccess: ((ResponseModel) -> ())?
    
    func getModels() {
        networkManager.fetchData(api: .daily) { [weak self] (response, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.complitionFailure?()
                return
            }
            guard let response = response else {
                self?.complitionFailure?()
                return
            }
            self?.complitionSuccess?(response)
        }
    }
}
