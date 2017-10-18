//
//  ViewController.swift
//  BankTransactions
//
//  Created by Shamli on 10/16/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var operateAmount: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        operateAmount.delegate = self
        balanceLabel.text = String(totalBalance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //----- bank logic -----
    //public
    typealias Transactions = (transId: Int, amount: Double, balance:Double, transType: String)
    
    var transactionHistory:[Transactions] = []
    
    func debit(_ amount: Double) -> Double {
        return -1 * amount
    }
    
    func credit(_ amount: Double) -> Double {
        return amount
    }
    
    func updateBalance(_ balance: inout Double, _ action: (Double) -> Double, _ amount: Double) -> Bool {
        let operation: Double = action(amount)
        if(operation < 0) {
            if amount > balance {
                print("Cannot withdraw! Insufficient balance!")
                callAlert(alertTitle: "Invalid Transaction!", alertMessage: "Insufficient balance")
                return false
            }
            else if balance == minBalance {
                print("Cannot withdraw! Minimum balance already reached!")
                callAlert(alertTitle: "Invalid Transaction!", alertMessage: "Minimum balance already reached")
                return false
            }
            else if amount >= balance {
                print("Cannot withdraw! Minimum balance needs to be maintained!")
                callAlert(alertTitle: "Invalid Transaction!", alertMessage: "Minimum balance needs to be maintained")
                return false
            }
            else {
                balance += operation
                print("\(amount) withdrawn...")
                print("New balance: \(balance)")
                callAlert(alertTitle: "Done!", alertMessage: "Account debited")
                return true
            }
        }
        else {
            balance += operation
            print("\(amount) deposited...")
            print("New balance: \(balance)")
            callAlert(alertTitle: "Done!", alertMessage: "Account credited")
            return true
        }
    }
    
    //initial values
    var tid: Int = 0
    var tAmount: Double = 0
    var totalBalance: Double = 15000 //initial fixed amount
    var transactionType: String = ""
    var minBalance: Double = 1000
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === operateAmount {
            tAmount = Double(operateAmount.text!)!
        }
    }
    
    //----- button actions -----
    @IBAction func debitAction(_ sender: UIButton) {
        let myDebit = debit
        let updated:Bool = updateBalance(&totalBalance, myDebit, tAmount)
        if updated {
            tid += 1
            transactionType = "DB"
            let transaction:Transactions = (transId: tid, amount: tAmount, balance:totalBalance, transType: transactionType)
            transactionHistory.append(transaction)
            balanceLabel.text = String(totalBalance)
            print(transactionHistory)
        }
        else {
            operateAmount.text = ""
        }
    }
    
    @IBAction func creditAction(_ sender: UIButton) {
        let myCredit = credit
        let updated:Bool = updateBalance(&totalBalance, myCredit, tAmount)
        if updated {
            tid += 1
            transactionType = "CR"
            let transaction:Transactions = (transId: tid, amount: tAmount, balance:totalBalance, transType: transactionType)
            transactionHistory.append(transaction)
            balanceLabel.text = String(totalBalance)
            print(transactionHistory)
        }
    }
    
    //----- passbook logic: send data to another controller -----
    @IBAction func viewPassbook(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination:PassbookTableViewController = segue.destination as! PassbookTableViewController
        destination.passbook = transactionHistory //send through segue
    }
    
    //----- alerts' generic function -----
    func callAlert(alertTitle: String, alertMessage: String) {
        let alertControl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
    }
}

