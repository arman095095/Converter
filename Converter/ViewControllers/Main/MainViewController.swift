//
//  MainViewController.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var viewModel: MainCurrencyViewModelProtocol!
    
    override func viewDidLoad() {
        setupViews()
        setupBinding()
    }
    
    @objc private func textChangeInLeft() {
        guard let nominal = self.leftTextField.text else { return }
        self.viewModel.leftValue = nominal
        
    }
    @objc private func textChangeInRight() {
        guard let nominal = self.rightTextField.text else { return }
        self.viewModel.rightValue = nominal
    }
    
    @IBAction func leftAction(_ sender: Any) {
        let vc = Builder.getChangeCurrencyVC(delegate: self, type: .left, models: viewModel.getModels(),selectedItem: viewModel.selectedLeft)
        present(vc, animated: true, completion: nil)
    }
    @IBAction func rightAction(_ sender: Any) {
        let vc = Builder.getChangeCurrencyVC(delegate: self, type: .right, models: viewModel.getModels(),selectedItem: viewModel.selectedRight)
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: ChangeCurrencyDelegate {
    func update(type: ChangeType, item: Currency) {
        switch type {
        case .left:
            self.viewModel.selectedLeft = item
        case .right:
            self.viewModel.selectedRight = item
        }
    }
}

private extension MainViewController {
    
    func setupBinding() {
        viewModel.selectingBind = { vModel in
            self.leftLabel.text = vModel.selectedLeft.name
            self.rightLabel.text = vModel.selectedRight.name
            self.rightTextField.text = vModel.calculateForRight(nominal: self.leftTextField.text!)
        }
        viewModel.changeValueBindForLeft = { value in
            self.rightTextField.text = value
        }
        viewModel.changeValueBindForRight = { value in
            self.leftTextField.text = value
        }
    }
    
    func setupViews() {
        rightButton.titleLabel?.textAlignment = .center
        leftButton.titleLabel?.textAlignment = .center
        
        leftTextField.addTarget(self, action: #selector(textChangeInLeft), for: .editingChanged)
        rightTextField.addTarget(self, action: #selector(textChangeInRight), for: .editingChanged)
    }
}


