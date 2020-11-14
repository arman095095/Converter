//
//  NetworkManager.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class NetworkManager {
    
    var urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    func fetchData(complition: @escaping (ResponseModel?,Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(nil,error)
                return
            }
            guard let data = data else {
                complition(nil,nil)
                return
            }
            guard let response = try? JSONDecoder().decode(ResponseModel.self, from: data) else {
                complition(nil,nil)
                print("ошибка2")
                return
            }
            complition(response,nil)
        }.resume()
    }
}
