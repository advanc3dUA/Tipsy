//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitStepper: UIStepper!

    var tips = 0.1
    var billTotal: Double?
    var eachPayment: Double?
    var people = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.people = people
            resultsVC.tips = tips
            resultsVC.totalByPerson = eachPayment
        }
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        selectTipButton(for: sender)
        //billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", splitStepper.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        getSelectedTips()
        getNumberOfPeople()
        getBillTotal()
        calcEachHaveToPay()
        self.performSegue(withIdentifier: "showResults", sender: self)
    }
    
    private func calcEachHaveToPay() {
        guard let safeTotal = billTotal else { return }
        eachPayment = Double((safeTotal * (1 + tips)) / Double(people))
    }
    
    private func selectTipButton(for button: UIButton) {
        switch button.currentTitle {
        case "0%":
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        case "10%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
        case "20%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
        default: return
        }
    }
    
    private func getSelectedTips() {
        if zeroPctButton.isSelected {
            tips = 0.0
        }
        if tenPctButton.isSelected {
            tips = 0.1
        }
        if twentyPctButton.isSelected {
            tips = 0.2
        }
    }
    
    private func getNumberOfPeople() {
        people = Int(splitStepper.value)
    }
    
    private func getBillTotal() {
        if billTextField.text == "" {
            billTotal = 0.0
        } else {
            billTotal = Double(billTextField.text!)
        }
    }
        
    private func setupToolbar() {
        //Create a toolbar
        let bar = UIToolbar()
        //Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        //Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //Add the created button items in the toobar
        bar.items = [flexSpace, doneBtn]
        bar.sizeToFit()
        //Add the toolbar to our textfield
        billTextField.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}

