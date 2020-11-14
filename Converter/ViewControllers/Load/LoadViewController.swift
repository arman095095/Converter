//
//  LoadViewController.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class LoadViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        getModels()
    }
    
    private func getModels() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networkManager.fetchData { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                self.stopLoading()
                return
            }
            guard let response = response else {
                self.stopLoading()
                return
            }
            self.presentMainVC(with: response)
        }
    }
    
    private func presentMainVC(with model: ResponseModel) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            let vc = Builder.getMainVC(model: model)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    
}
