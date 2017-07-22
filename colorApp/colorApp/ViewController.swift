//
//  ViewController.swift
//  colorApp
//
//  Created by Md Ibrahim Hassan on 13/06/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSTextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var blueTextField: NSTextField!
    @IBOutlet weak var greenTextField: NSTextField!
    @IBOutlet weak var redTextField: NSTextField!
//    func controlTextDidChange(obj: NSNotification) {
//        let characterSet: NSCharacterSet = NSCharacterSet(charactersIn: "0123456789.").inverted as NSCharacterSet
//        self.blueTextField.stringValue = (self.blueTextField.stringValue.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("")
//            self.greenTextField.stringValue = (self.greenTextField.stringValue.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("")
//            self.redTextField.stringValue = (self.redTextField.stringValue.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("")
//    }
//    


}

