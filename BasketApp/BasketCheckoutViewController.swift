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
            }
        }
    }
    
    var basket: [BasketElement]!
    var currencyList: [String]!
    var exchangeHandler: CurrencyConnectionHandler!
    fileprivate var selectedCurrency: String! = "USD"
    private var sumPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        self.sumPriceLabel.text = self.sumPrice.description
        self.currencyList = self.currencyList.sorted()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.basket = nil
        self.currencyList = nil
        self.exchangeHandler = nil
        super.viewDidDisappear(animated)
    }
    
    private func calculateSumPrice() {
        if let basket = basket {
            for element in basket {
                self.sumPrice += element.price
            }
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
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        } else if editingStyle == .insert {
            // currently nothing to do
        }
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
