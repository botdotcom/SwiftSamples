//
//  AddViewController.swift
//  UniversityApp
//
//  Created by Shamli on 10/20/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    //public var university: University? = nil
    
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var subject1: UITextField!
    @IBOutlet weak var subject2: UITextField!
    @IBOutlet weak var subject3: UITextField!
    @IBOutlet weak var subject4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        studentName.delegate = self
        subject1.delegate = self
        subject2.delegate = self
        subject3.delegate = self
        subject4.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    var name: String = ""
    var sub1:Double = 0.0
    var sub2:Double = 0.0
    var sub3:Double = 0.0
    var sub4:Double = 0.0
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField === studentName {
            name = textField.text!
        }
        if textField === subject1 {
            sub1 = Double(textField.text!)!
        }
        if textField === subject2 {
            sub2 = Double(textField.text!)!
        }
        if textField === subject3 {
            sub3 = Double(textField.text!)!
        }
        if textField === subject4 {
            sub4 = Double(textField.text!)!
        }
    }
    
    @IBAction func addClick(_ sender: Any) {
        id += 1
        let student = Student(id: id, name: name)
        student.addMarks(subject: "English", marks: sub1)
        student.addMarks(subject: "Maths", marks: sub2)
        student.addMarks(subject: "Science", marks: sub3)
        student.addMarks(subject: "Computers", marks: sub4)
        student.calculatePercentage()
        university.addNewStudent(student)
        alertCall("Done", "Student added successfully!")
        print("Student added...")
        //print(student.studentId, student.studentName, student.percentage) //for log
        studentName.text = ""
        subject1.text = ""
        subject2.text = ""
        subject3.text = ""
        subject4.text = ""
    }
    
    func alertCall(_ alertTitle: String, _ alertMessage: String) {
        let alertControl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
    }

}
