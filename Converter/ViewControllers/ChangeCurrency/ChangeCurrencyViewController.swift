//
//  ChangeCurrency.swift
//  Converter
//
//  Created by Arman Davidoff on 29.10.2020.
//

import UIKit

enum ChangeType {
    case left
    case right
}

protocol ChangeCurrencyDelegate: AnyObject {
    func update(type: ChangeType, item: Currency)
}

class ChangeCurrencyViewController: UIViewController {
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ChangeCurrencyViewModelProtocol!
    weak var delegate: ChangeCurrencyDelegate?
    
    override func viewDidLoad() {
        setupTableView()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib.init(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension ChangeCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let item = viewModel.getItem(for: indexPath)
        cell.setup(model: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.itemForSend(for: indexPath)
        delegate?.update(type: viewModel.changeSide, item: item)
        dismiss(animated: true, completion: nil)
    }
}

