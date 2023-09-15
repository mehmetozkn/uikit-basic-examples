//
//  User.swift
//  OOPExample
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import Foundation

enum UserType {
    case Admin
    case Normal
    
}

class User {
    var name : String
    var age : Int
    var type : UserType
    private var gender : String = "Erkek"
    
    
    init(name: String, age: Int, type: UserType) {
        self.name = name
        self.age = age
        self.type = type
    }
    
    func myFuncExample (){
        print("My Func Example Run")
    }
    
    
    
}
