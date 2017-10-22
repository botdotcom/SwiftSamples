//
//  University.swift
//  UniversityApp
//
//  Created by Shamli on 10/20/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import Foundation

class University {
    var allStudents: [Int: Student] = [:] //collection of students, identified by their unique IDs
    
    func addNewStudent(_ student: Student) {
        allStudents[student.studentId] = student
    }
    
    func getStudentsList() -> [Student] {
        var students: [Student] = []
        for s in allStudents.values {
            students.append(s)
        }
        return students
    }
    
    func getHighest() -> Student {
        var highest: Student? = nil
        var maxPercent: Double = 0
        for student in allStudents.values {
            if maxPercent < student.percentage {
                maxPercent = student.percentage
                highest = student
            }
        }
        return highest!
    }
    
    func getDistinctionList() -> [Student] {
        var distinction:[Student] = []
        for student in allStudents.values {
            let percent = student.percentage
            if percent >= 75 {
                distinction.append(student)
            }
        }
        return distinction
    }
    
    func getFirstClassList() -> [Student] {
        var firstClass:[Student] = []
        for student in allStudents.values {
            let percent = student.percentage
            if percent >= 60 && percent < 75 {
                firstClass.append(student)
            }
        }
        return firstClass
    }
    
    func getSecondClassList() -> [Student] {
        var secondClass:[Student] = []
        for student in allStudents.values {
            let percent = student.percentage
            if percent >= 50 && percent < 60 {
                secondClass.append(student)
            }
        }
        return secondClass
    }
    
    func getPassList() -> [Student] {
        var passed:[Student] = []
        for student in allStudents.values {
            let percent = student.percentage
            if percent >= 35 && percent < 50 {
                passed.append(student)
            }
        }
        return passed
    }
    
    func getFailedList() -> [Student] {
        var failed:[Student] = []
        for student in allStudents.values {
            let percent = student.percentage
            if percent < 35 {
                failed.append(student)
            }
        }
        return failed
    }
}


let university = University()
  var id: Int = 0
