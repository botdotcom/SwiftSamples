//
//  Student.swift
//  UniversityApp
//
//  Created by Shamli on 10/20/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import Foundation

class Student {
    var studentId: Int = 0
    var studentName: String = ""
    var studentMarks: [String: Double] = [:]
    var percentage: Double = 0
    
    init(id: Int, name: String) {
        studentId = id
        studentName = name
    }
    
    func addMarks(subject: String, marks: Double) {
        studentMarks[subject] = marks
    }
    
    func calculatePercentage() {
        for marks in studentMarks.values {
            percentage += marks
        }
        percentage /= Double(studentMarks.count)
    }
}
