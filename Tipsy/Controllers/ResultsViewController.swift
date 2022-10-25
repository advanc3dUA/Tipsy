//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by advanc3d on 25.10.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var people = 2
    var tips = 0.1
    var totalByPerson: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(totalByPerson)
        guard let safeTotal = totalByPerson else { return }
        totalLabel.text = String(format: "%.2f", safeTotal)
        settingsLabel.text = "Split between \(people) people, with \(tips * 100)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
