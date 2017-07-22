//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
// Bubble Sort
var a:[Int] = [100, 90, 80, 70, 60, 50, 40, 40, 20, 10]
for i in 0...a.count - 2{
    for j in 0...a.count - 2{
        if (a[j] > a[j+1]){//Change sign here for Descending sort
//            Swapping using temp Var
//            let x = a[j]
//            a[j] = a[j+1]
//            a[j+1] = x
            a[j] = a[j+1] + a[j]
            a[j+1] = a[j] - a[j+1]
            a[j] = a[j] - a[j+1]

        }
    }
}
print (a)
a = [100, 90, 80, 70, 60, 50, 40, 40, 20, 10]
//Selection Sort
var sloc = 0
for i in 0...a.count - 2{
    sloc = i
    for j in (i+1)...a.count - 1{
        if (a[sloc] > a[j]){//Change sign here for Descending sort
            sloc = j
        }
    }
    let x = a[i]
    a[i] = a[sloc]
    a[sloc] = x
}
print (a)

//Searching 

//Binary Search

var flag : Bool = false
var valueToSearch : Int = 60
for i in 0...a.count - 1{
    if (a[i] == valueToSearch){
        flag = true
    }
}
if (flag){
    print ("Value Found")
}
else{
    print("Value not found")
}

//Linear Search
var flagLinear : Bool = false
let n : Int = 70
var startIndex : Int = 0
var endIndex : Int = a.count - 1
while (startIndex <= endIndex){
    let middleIndex : Int = (startIndex + endIndex)/2
    if (n == a[middleIndex]){
        flagLinear = true
        RETURN
    }
    if (n > a[middleIndex]){
        startIndex = middleIndex + 1
    }
    else{
        endIndex = endIndex - 1
    }
}
if (flagLinear){
    print ("Value Found")
}