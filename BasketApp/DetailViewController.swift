//
//  DetailViewController.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.name.capitalized
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

    var detailItem: BasketElement? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

