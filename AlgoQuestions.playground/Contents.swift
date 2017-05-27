//: Solving Suppose we are comparing implementations of insertion sort and merge sort on the same machine. For inputs of size n, insertion sort runs in 8n2 steps, while merge sort runs in 64n lg n steps. For which values of n does insertion sort beat merge sort?


import UIKit
var test : Bool = true
var n = 0
while (test)
{
    n += 1
    let lhs = 8 * n * n
    let rhs = 64 * log2(Double(n))
    if (lhs == Int(rhs))
    {
        print ("Problem 1 solved. The required value is :\(n)")
        print (lhs)
        print (rhs)
        test = true
        break
    }
}






//:1.2-3
//:What is the smallest value of n such that an algorithm whose running time is 100n2 runs faster than an algorithm whose running time is 2n on the same machine?
var na : Double = 0.1
let lhs = 100 * pow(Decimal(na), 2)
let rhs = pow(2, na)
print (lhs)
print (rhs)
while (test)
{
    na -= 0.001
    let lhs = 100 * pow(Decimal(na), 2)
    let rhs = pow(2, na)
    if (lhs == Decimal(rhs))
    {
        print ("Problem 1 solved. The required value is :\(na)")
        print (lhs)
        print (rhs)
        test = true
        break
    }
}
//: Reversing an Array Using a single array

//:1-1 Comparison of running times
//:For each function f .n/ and time t in the following table, determine the largest size n of a problem that can be solved in time t, assuming that the algorithm to solve the problem takes f .n/ microseconds.
