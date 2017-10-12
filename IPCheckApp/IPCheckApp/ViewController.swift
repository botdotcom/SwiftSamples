//
//  ViewController.swift
//  IPCheckApp
//
//  Created by Shamli on 10/12/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serverName: UITextField!
    @IBOutlet weak var serverIp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serverName.delegate = self
        serverIp.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var name:String = ""
    var ipAddress:String = ""
    
    //check which text field is edited
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === serverName {
            name = textField.text!
        }
        else if textField === serverIp {
            ipAddress = textField.text!
        }
    }

    @IBAction func submitCheck(_ sender: UIButton) {
        if (name.characters.count > 0) && (ipAddress.characters.count > 0) {
            if checkIpFormat(ip: ipAddress) {
                print("Server name = \(name), Server IP = \(ipAddress)")
            }
            else {
                print("Enter valid format of IP address!")
            }
        }
        else {
            print("Enter data!")
        }
    }
    
    func checkIpFormat(ip:String) -> Bool {
        var ipDots = 0
        var correct = false
        //check for number of dots
        for char in ip.characters {
            if char == "." {
                ipDots += 1
            }
        }
        //return for dots less than 3; don't go further
        if ipDots < 3 {
            return false
        }
        //check if number
        let ipArr = ip.components(separatedBy: ".")
        var ipNumArr:[Int] = []
        for i in ipArr {
            let ipNum = Int(i)
            if ipNum != nil {
                ipNumArr.append(ipNum!)
            }
            else {
                return false
            }
        }
        //check for range of number
        for i in ipNumArr {
            if i<0 || i>255 {
                correct = false
                break
            }
            else {
                correct = true
            }
        }
        //return for number format
        return correct
    }
}

