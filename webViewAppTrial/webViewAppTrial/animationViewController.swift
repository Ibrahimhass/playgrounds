//
//  animationViewController.swift
//  webViewAppTrial
//
//  Created by Md Ibrahim Hassan on 20/06/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class animationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        yPosLabel = self.myLabel.frame.origin.y
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var myLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var yPosLabel : CGFloat!
    @IBAction func animate(_ sender: Any) {
        UIView.animate(withDuration: 10, animations: {
            self.myLabel.frame.origin.y -= 500
        }, completion: nil )
    }
    @IBAction func reset(_ sender: Any) {
        view.layer.removeAllAnimations()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        let newFrame = CGRect(x:self.myLabel.frame.origin.x, y:yPosLabel,
                              width:self.myLabel.frame.size.width, height:self.myLabel.frame.size.height)
        self.myLabel.frame = newFrame
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
