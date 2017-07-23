//
//  MasterViewController.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var basket = [BasketElement]()
    let connectionHandler = CurrencyConnectionHandler()

    override func viewDidLoad() {
        self.createElementsToBasket()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        connectionHandler.loadCurrencyList()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
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
                controller.detailItem = self.basket[indexPath]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basket.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
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

}

    //MARK: - Basket related functions in extension
extension MasterViewController {
    func createElementsToBasket() {
        let eggs = BasketElement(type: .eggs, price: 2.10)
        let beans = BasketElement(type: .beans, price: 0.73)
        let milk = BasketElement(type: .milk, price: 1.30)
        let peas = BasketElement(type: .peas, price: 0.95)
        
        basket.append(peas)
        basket.append(eggs)
        basket.append(milk)
        basket.append(beans)
    }
}

