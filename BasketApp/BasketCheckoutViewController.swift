//
//  BasketCheckoutViewController.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 24..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import UIKit

class BasketCheckoutViewController: UITableViewController, BasketProperties {
    
    @IBOutlet weak var sumPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBAction func convertPrice(_ sender: Any) {
        self.exchangeHandler.loadExchangeRate(to: self.selectedCurrency) { exchangeRate in
            self.sumPrice *= exchangeRate
            DispatchQueue.main.async {
                self.sumPriceLabel.text = self.sumPrice.description
                self.showCurrencyAlert()
            }
        }
    }
    
    var basket: [BasketElement]!
    var currencyList: [String]!
    var exchangeHandler: CurrencyConnectionHandler!
    // The currency layer API restricts other sources for my account, only the default USD works
    fileprivate var selectedCurrency: String!
    private var sumPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        self.calculateSumPrice()
        self.sumPriceLabel.text = String(describing: self.sumPrice)
        self.currencyList = self.currencyList.sorted()
        self.selectedCurrency = self.currencyList.first!.uppercased()
    }
    
    private func calculateSumPrice() {
        if let basket = basket {
            for element in basket {
                self.sumPrice += element.price
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "The basket is not empty!", message: "Do you want to remove the content of the basket?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.basket.removeAll()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showCurrencyAlert() {
        if self.selectedCurrency != "USD" {
            let alert = UIAlertController(title: "Information", message: "The currency layer API restricts the API usage for this account, only the default USD source is enabled", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basket?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        configureCell(cell, with: (self.basket?[indexPath.item])!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    private func configureCell(_ cell: UITableViewCell, with element: BasketElement) {
        cell.textLabel!.text = element.name + " \(element.price) \(element.currency)"
    }
}

extension BasketCheckoutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencyList.count
    }
    
    // MARK: - UIPickerViewDelegate optional functions
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.currencyList[row].uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrency = self.currencyList[row].uppercased()
    }
    
}
