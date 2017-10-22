//
//  DetailsViewController.swift
//  UniversityApp
//
//  Created by Shamli on 10/21/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    public var student:Student?
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var englishMarks: UILabel!
    @IBOutlet weak var mathsMarks: UILabel!
    @IBOutlet weak var scienceMarks: UILabel!
    @IBOutlet weak var computersMarks: UILabel!
    @IBOutlet weak var studentPercentage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        studentName.text = student?.studentName
        //englishMarks.text = String(student?.studentMarks["English"])
        englishMarks.text = String(describing: student?.studentMarks["English"])
        mathsMarks.text = String(describing: student?.studentMarks["Maths"])
        scienceMarks.text = String(describing: student?.studentMarks["Science"])
        computersMarks.text = String(describing: student?.studentMarks["Computers"])
        studentPercentage.text = String(describing: student?.percentage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
