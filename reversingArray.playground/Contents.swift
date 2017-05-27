//: Playground - noun: a place where people can play

import UIKit
//: Reversing an Array Using a single array
var array : [Int] = [1,2,3,4,5,6,7,8,9,10]
for i in (0..<array.count).reversed() {
    array.append(array[i])
}
//array.removeFirst(array.count/2)
print (array)

//for i in 0..<array.count{
//        let arrayCount = array.count - i - 1
//        let element = array[arrayCount]
//        print (element)
////    array[i] = element
////        array[i] = array[arrayCount]
//}
//print (array.removeLast(5))
