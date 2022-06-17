//
//  ViewController.swift
//  Assignment2b
//
//  Created by Joshua Boyd on 6/16/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loanAmountOutlet: UITextField!
        
    @IBOutlet weak var numOfPmtsOutlet: UITextField!
        
    @IBOutlet weak var interestRateOutlet: UITextField!

    @IBOutlet weak var pmtAmountOutlet: UILabel!
        
    @IBOutlet weak var pmtPeriodToggle: UISwitch!
        
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        loanAmountOutlet.resignFirstResponder()
        numOfPmtsOutlet.resignFirstResponder()
        interestRateOutlet.resignFirstResponder()
    }
        
    @IBAction func onButtonPress(_ sender: UIButton) {
            
        let loanAmount = loanAmountOutlet.text! == "" ?  0.00 : Float(loanAmountOutlet.text!) ?? 0.00
            
        let numOfPmts = numOfPmtsOutlet.text! == "" ? 0 : Int(numOfPmtsOutlet.text!) ?? 0
            
        var interestRate = interestRateOutlet.text! == "" ? 0.00 : Float(interestRateOutlet.text!) ?? 0.00
            
        interestRate /= 100.0
            
        if(!pmtPeriodToggle.isOn) {
            interestRate /= 12
        }
            
        let fracPrePow = 1 + interestRate
        let fracPow = pow(fracPrePow, Float(numOfPmts))

        let formulaTop = interestRate * fracPow
                
        let formulaBottom = fracPow - 1
                
        let formulaFrac = formulaTop / formulaBottom
            
        let pmtAmount: Float = Float(loanAmount) * formulaFrac
            
        pmtAmountOutlet.text = "$" + String(round(pmtAmount * 100) / 100.0)
    }


}

