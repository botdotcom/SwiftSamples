//
//  ViewController.swift
//  PhoneBook
//
//  Created by Shamli on 10/13/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userContact: UITextField!
    @IBOutlet weak var contactTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userName.delegate = self
        userContact.delegate = self
        contactTable.delegate = self
        contactTable.dataSource = self
    }
    
    //----- text fields handling -----
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var name:String = ""
    var contact:String = ""
    
    func textFieldDidEndEditing(_ textField: UITextField){
        //save contact name
        if textField === userName {
            name = textField.text!
        }
        if textField === userContact {
            //----- mobile number validation -----
            contact = textField.text!
            //length of mobile number
            if((contact.characters.count) < 10) || ((contact.characters.count) > 10) {
                textField.text = ""
                contact = ""
                print("Enter contact number of size 10")
                //alert user
                let alertControl = UIAlertController(title: "Invalid!", message: "Contact number should have size 10", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertControl.addAction(okAction)
                present(alertControl, animated: true, completion: nil)
            }
            else {
                //if contains only digits
                if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: contact)) {
                    textField.text = ""
                    contact = ""
                    print("Enter only numeric characters")
                    //alert user
                    let alertControl = UIAlertController(title: "Invalid!", message: "Contact number should contain only digits", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertControl.addAction(okAction)
                    present(alertControl, animated: true, completion: nil)
                }
            }
            //if number starts with 7, 8 or 9
            if !contact.hasPrefix("9") && !contact.hasPrefix("8") && !contact.hasPrefix("7") {
                textField.text = ""
                contact = ""
                print("Should start with 7, 8 or 9")
                //alert user
                let alertControl = UIAlertController(title: "Invalid!", message: "Contact number should start with 7, 8 or 9", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertControl.addAction(okAction)
                present(alertControl, animated: true, completion: nil)

            }
        }
    }
    
    var phoneBook: [String: String] = [:]
    
    @IBAction func saveClick(_ sender: UIButton) {
        phoneBook[name] = contact //save contact to dictionary
        print("Contact saved...")
        print(phoneBook)
        //alert user
        let alertControl = UIAlertController(title: "Successful!", message: "Contact saved", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
        contactTable.reloadData()
    }
    
    //----- table handling -----
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTable.dequeueReusableCell(withIdentifier: "contactCell")
        cell?.textLabel?.text = Array(phoneBook)[indexPath.row].key
        cell?.detailTextLabel?.text = Array(phoneBook)[indexPath.row].value
        return cell!
    }
    
    //----- deleting contacts -----
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedName = Array(phoneBook)[indexPath.row].key
        if phoneBook.isEmpty {
            print("No contact to delete!")
        }
        else {
            phoneBook.removeValue(forKey: selectedName)
            print("Contact deleted...")
            print(phoneBook)
            //alert user
            let alertControl = UIAlertController(title: "Successful!", message: "Contact deleted", preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertControl.addAction(okAction)
            present(alertControl, animated: true, completion: nil)
            contactTable.reloadData()
        }
    }
}

