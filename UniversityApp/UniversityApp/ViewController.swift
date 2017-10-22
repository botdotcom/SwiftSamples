//
//  ViewController.swift
//  UniversityApp
//
//  Created by Shamli on 10/20/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addStudentClick(_ sender: UIButton) {
    }
    
    @IBAction func showStudentsListClick(_ sender: UIButton) {
    }
    
    @IBAction func showDistinctionClick(_ sender: UIButton) {
    }
    
    @IBAction func getTopperClick(_ sender: UIButton) {
        let student:Student!
        student = university.getHighest() //get the topper
        if student != nil {
            alertCall("Topper", "\(student.studentName) : \(student.percentage)")
        }
        else {
            alertCall("Oops!", "No topper to show!")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentListSegue" {
            let destination = segue.destination as! StudentsListViewController            
            destination.typeOfData = 0
            print("Student list called through segue...")
        }
    }

    func alertCall(_ alertTitle: String, _ alertMessage: String) {
        let alertControl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
    }
}

