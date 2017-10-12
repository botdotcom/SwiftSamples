//: Playground - noun: a place where people can play

import UIKit

//check all numbers from 1 to limit

func isPrime(number: Int) -> Bool {
    if number <= 1 {
        return false
    }
    //for 2 and 3
    if number <= 3 {
        return true
    }
    //for numbers till 25
    if (number % 2 == 0) || (number % 3 == 0) {
        return false
    }
    //for rest numbers
    var i = 5
    while i*i <= number {
        if (number % i == 0) || (number % (i+2) == 0) {
            return false
        }
        i += 6
    }
    return true
}


for num in 1...100 {
    if isPrime(number: num) {
        print("\(num) is prime")
    }
}



