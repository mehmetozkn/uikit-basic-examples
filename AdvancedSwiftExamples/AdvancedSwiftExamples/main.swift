//
//  main.swift
//  AdvancedSwiftExamples
//
//  Created by Mehmet Özkan on 16.09.2023.


import Foundation


// Struct -> inheritance yok, stack - filo (RAM), daha hızlı, daha basit, value type, immutable
// Class -> inheritance var, heap - fifo (RAM), reference type, mutable

let user1 = MyUserClass(name: "Mehmet", age: 22, job: "Software Developer")
let user2 = user1


print(user1.name)
print(user2.name)

user2.name = "Ahmet"

print(user1.name)
print(user2.name)


var user4 = UserStruct(name: "Osman", age: 10, job: "Öğretmen")
let user5 = user4


print(user4.name)
print(user5.name)

user4.name = "Dogukan"

print(user4.name)
print(user5.name)


// Tuples
var myTuple1 = (10, 20)

print(myTuple1.0)


let myTuple2 = ("Mehmet", [1, 2, 3, 4])
print(myTuple2.1[0])

let myTuple3 = (name: "mehmet", surname: "Ozkan")
print(myTuple3.name)


// Guard Let

// let numString = "atıl" // 0 döndürür
let numString = "5" // numaray çevirir ve dogru şekilde döndürür
func inteCevirenIfLetFunc(string: String) -> Int {
    if let myNum = Int(string) {
        return myNum
    } else {
        return 0
    }
    
}

print(inteCevirenIfLetFunc(string: numString))


func inteCevirenGuardLetFunc(string: String) -> Int {
    
    guard let myNum = Int(string) else {
        return 0
    }
    return myNum
}

print(inteCevirenGuardLetFunc(string: numString))





