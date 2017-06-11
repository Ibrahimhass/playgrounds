//: Playground - noun: a place where people can play

import UIKit

import AVFoundation
let url = NSURL(string:
    "http://www.publicbroadcasting.net/wgvu/ppr/wgvufm.m3u")
let player = AVPlayer(url: url! as URL)
player.play()

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
