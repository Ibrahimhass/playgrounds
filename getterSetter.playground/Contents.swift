//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
struct Animal {
    var name: String = ""
    var heightInches = 0.0
    var heightCM: Double {
        get{
            return 2.54*heightInches
        }
        set(newHeightCM){
            heightInches=newHeightCM / 2.54
        }
    }
}
var dog=Animal (name: "dog", heightInches: 50)
dog.heightInches
dog.heightCM
dog.heightCM=254
dog.heightInches

let novalue:Int? = nil
