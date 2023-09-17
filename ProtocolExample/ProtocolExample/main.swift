//
//  main.swift
//  ProtocolExample
//
//  Created by Mehmet Özkan on 17.09.2023.
//

import Foundation

protocol Running {
    func myRun()
}

class Animal {
   func test()
    {
        print("test")
    }}


class Dog : Running {
    func myRun() {
        print("running")
    }
    
}


class Cat : Animal, Running {
    func myRun() {
        print("running")
    }
    
}

let cat = Cat()
cat.test()
cat.myRun()

class Turtle : Running {
    func myRun() {
        print("running")
    }
    
}

