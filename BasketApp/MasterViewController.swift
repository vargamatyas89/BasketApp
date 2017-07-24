//
//  MasterViewController.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, BasketProperties {

    var detailViewController: DetailViewController!
    var basket: [BasketElement]!
    var currencyList: [String]!
    fileprivate var initialBasket: [BasketElement]!
    fileprivate let connectionHandler = CurrencyConnectionHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        self.createElementsToBasket()
        self.connectionHandler.loadCurrencyList { json in
            if let json = json {
                self.currencyList = self.expandCurrenciesFromDictionary(json)
            }
        }
        
        self.basket = [BasketElement]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow?.item {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                let basketElement = self.initialBasket[indexPath]
                controller.basketElement = basketElement
                controller.title = controller.basketElement?.name
                controller.basket = self.basket
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "checkout" {
            let controller = (segue.destination as! UINavigationController).topViewController as! BasketCheckoutViewController
            controller.currencyList = self.currencyList
            controller.basket = self.basket
            controller.exchangeHandler = self.connectionHandler
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.initialBasket.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        self.configureCell(cell, with: self.initialBasket[indexPath.item])
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
        cell.textLabel!.text = element.name
    }

}

    //MARK: - Basket related functions in extension
extension MasterViewController {
    fileprivate func createElementsToBasket() {
        let eggs = BasketElement(type: .eggs, price: 2.10)
        let beans = BasketElement(type: .beans, price: 0.73)
        let milk = BasketElement(type: .milk, price: 1.30)
        let peas = BasketElement(type: .peas, price: 0.95)
        
        self.initialBasket = [BasketElement]()
        self.initialBasket.append(peas)
        self.initialBasket.append(eggs)
        self.initialBasket.append(milk)
        self.initialBasket.append(beans)
    }
    
    fileprivate func expandCurrenciesFromDictionary(_ json: [String: Any]) -> [String] {
        var result = [String]()
        for (key, _) in json {
            result.append(key)
        }
        return result
    }
}

