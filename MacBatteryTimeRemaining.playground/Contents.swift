//: Playground - noun: a place where people can play

//import Cocoa
//var str = "Hello, playground"

import Foundation
import IOKit.ps

// Take a snapshot of all the power source info
let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()

// Pull out a list of power sources
let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array



// For each power source...
/*
func myFunc(){
    for ps in sources {
        // Fetch the information for a given power source out of our snapshot
        let info = IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as Dictionary
        
        // Pull out the name and capacity
        if let
            name = info[kIOPSNameKey] as? String,
            let capacity = info[kIOPSCurrentCapacityKey] as? Int,
            let max = info[kIOPSMaxCapacityKey] as? Int {
            print("\(name): \(capacity) of \(max)")
        }
    }
}
self.myFunc()
 */