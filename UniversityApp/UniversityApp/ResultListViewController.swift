//
//  ResultListViewController.swift
//  UniversityApp
//
//  Created by Shamli on 10/21/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class ResultListViewController: UIViewController {
    
    public var typeOfData: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func distinctionClick(_ sender: UIButton) {
        let count = university.getDistinctionList().count
        if count > 0 {
            typeOfData = 1
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
            alertCall("Oops!", "No list to show")
        }
    }
    
    @IBAction func firstClassClick(_ sender: UIButton) {
        let count = university.getFirstClassList().count
        if count > 0 {
            typeOfData = 2
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
            alertCall("Oops!", "No list to show")
        }
    }
    
    @IBAction func secondClassClick(_ sender: UIButton) {
        let count = university.getSecondClassList().count
        if count > 0 {
            typeOfData = 3
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
            alertCall("Oops!", "No list to show")
        }
    }
    
    @IBAction func passedClick(_ sender: UIButton) {
        let count = university.getPassList().count
        if count > 0 {
            typeOfData = 4
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
            alertCall("Oops!", "No list to show")
        }
    }
    
    @IBAction func failedClick(_ sender: UIButton) {
        let count = university.getFailedList().count
        if count > 0 {
            typeOfData = 5
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
            alertCall("Oops!", "No list to show")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! StudentsListViewController
        destination.typeOfData = typeOfData
        print("Type of result sent through segue...")
    }
    
    func alertCall(_ alertTitle: String, _ alertMessage: String) {
        let alertControl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
    }
}
