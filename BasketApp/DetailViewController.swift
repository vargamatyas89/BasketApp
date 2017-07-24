//
//  DetailViewController.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, BasketProperties {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBAction func addToBasket(_ sender: Any) {
        if self.basket == nil {
            self.basket = [BasketElement]()
        } else if self.basket.contains(self.basketElement!) {
            print("The basket already contains this element:")
            return
        }
        self.basket.append(self.basketElement!)
    }
    
    var basket: [BasketElement]!
    var currencyList: [String]!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = basketElement {
            if let label = detailDescriptionLabel {
                label.text = detail.currency.uppercased()
            }
            if let label2 = priceLabel {
                label2.text = String(describing: detail.price)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var basketElement: BasketElement? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

