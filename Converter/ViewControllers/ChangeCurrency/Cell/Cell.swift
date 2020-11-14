//
//  Cell.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyDescriptionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var mark: UIImageView!
    
    func setup(model: CurrencyModelType) {
        currencyLabel.text = model.name
        currencyDescriptionLabel.text = model.description
        mark.isHidden = !model.selected
    }
}
