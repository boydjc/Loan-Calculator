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
        
        var calcFlag: Bool = true
        
        if(Float(loanAmountOutlet.text!) == nil || Float(loanAmountOutlet.text!)! < 0) {
            showErrMsg(outletField: "Loan Amt")
            calcFlag = false
        }else if(Int(numOfPmtsOutlet.text!) == nil || Int(numOfPmtsOutlet.text!)! < 0) {
            showErrMsg(outletField: "Num Pmts")
            calcFlag = false
        }else if(Float(interestRateOutlet.text!) == nil || Float(interestRateOutlet.text!)! < 0) {
            showErrMsg(outletField: "Int. rate")
            calcFlag = false
        }
        
        let loanAmount = loanAmountOutlet.text! == "" ?  0.00 : Float(loanAmountOutlet.text!) ?? 0.00
        
        let numOfPmts = numOfPmtsOutlet.text! == "" ?  0 : Int(numOfPmtsOutlet.text!) ?? 0
        
        let interestRate = interestRateOutlet.text! == "" ?  0.00 : Float(interestRateOutlet.text!) ?? 0.00
                     
        if(calcFlag) {
            calcPayment(loanAmountIn: loanAmount, numOfPmtsIn: numOfPmts, interestRateIn: interestRate)
        }
    }
    
    func showErrMsg(outletField: String) {
        let msg = "You have invalid input in the " + outletField + " field."
        let errController = UIAlertController(title: "ERROR!", message: msg, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        errController.addAction(confirmAction)
        
        self.present(errController, animated: true, completion: nil)
    }
    
    func calcPayment(loanAmountIn: Float, numOfPmtsIn: Int, interestRateIn: Float) {
        
        var interestRate = interestRateIn;
        interestRate /= 100.0
            
        if(!pmtPeriodToggle.isOn) {
            interestRate /= 12
        }
            
        let fracPrePow = 1 + interestRate
        let fracPow = pow(fracPrePow, Float(numOfPmtsIn))

        let formulaTop = interestRate * fracPow
                
        let formulaBottom = fracPow - 1
                
        let formulaFrac = formulaTop / formulaBottom
            
        let pmtAmount: Float = Float(loanAmountIn) * formulaFrac
            
        pmtAmountOutlet.text = "$" + String(round(pmtAmount * 100) / 100.0)
    }


}

