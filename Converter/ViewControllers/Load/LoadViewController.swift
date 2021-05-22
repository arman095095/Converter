//
//  LoadViewController.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class LoadViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var viewModel = LoadViewModel()
    
    override func viewDidLoad() {
        setupBinding()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getModels()
    }
}

private extension LoadViewController {
    
    func setupBinding() {
        viewModel.complitionSuccess = { model in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                let vc = Builder.getMainVC(model: model)
                self.present(vc, animated: true, completion: nil)
            }
        }
        viewModel.complitionFailure = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
