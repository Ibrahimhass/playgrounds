//
//  bbbViewController.swift
//  TableViewExample
//
//  Created by Md Ibrahim Hassan on 16/07/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class bbbViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //MARK: - Variable and Outlets
    var conditionChecker : Bool = false
    var counter : Int = 1
    @IBOutlet var tableView: UITableView!
    @IBOutlet var slider: UISlider!
    static let numberOfCells : Int = 999
    //MARK: - View Controller Life-cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Rotatimg the slider
        let trans = CGAffineTransform(rotationAngle: .pi * 0.5)
        slider.transform = trans
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        if (self.tableView.contentSize.height < self.tableView.bounds.height){
            self.slider.isHidden = true
        }
    }
    
    //MARK: - TableView

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bbbViewController.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!bbbCellTableViewCell
        cell.hamraLabel.text = "\(indexPath.row + 1)"
        return cell
    }

    //MARK: - ScrollView

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let z = scrollView.contentSize.height

        if (!self.conditionChecker){
        if (y >= 0 && y + self.tableView.frame.size.height <= scrollView.contentSize.height){
        self.slider.setValue(Float.init(y/(z-self.tableView.bounds.height)), animated: false)
        }
        }
    }
    
    //MARK: - Slider

    @IBAction func sliderAction(_ sender: UISlider) {
        self.conditionChecker = true
        let value = sender.value
        let pop : CGFloat = CGFloat(value * Float(bbbViewController.numberOfCells))
        var newPop : Int = Int(pop)
        if (!sender.isTracking){
            if (counter % 2 == 0){
                self.conditionChecker = false
            }
            counter += 1
        }
        if (newPop == bbbViewController.numberOfCells){
            newPop = bbbViewController.numberOfCells - 1
        }
        let index = IndexPath.init(row: newPop, section: 0)
        self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
    }

}
//MARK: - Failed Attempts


//            if (y >= z*0.5){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height/2)/z), animated: true)
//            }
//            else if (z*0.1 <= y && z/5 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height/10)/z), animated: true)
//            }
//            else if (z/5 <= y && z * 0.3 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height/5)/z), animated: true)
//            }
//            else if (z*0.3 <= y && z * 0.4 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.3)/z), animated: true)
//            }
//            else if (z*0.4 <= y && z * 0.5 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.4)/z), animated: true)
//            }  else if (z*0.5 <= y && z * 0.6 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.5)/z), animated: true)
//            }  else if (z*0.6 <= y && z * 0.7 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.6)/z), animated: true)
//            }  else if (z*0.7 <= y && z * 0.8 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.7)/z), animated: true)
//            }
//            else if (z*0.8 <= y && z * 0.9 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.8)/z), animated: true)
//            }
//            else if (z*0.9 <= y && z * 0.91 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height*0.9)/z), animated: true)
//            }
//
//
//            else if (z/4 <= y){
//                self.slider.setValue(Float.init((y + self.tableView.bounds.height/4)/z), animated: true)
//            }
//            else if (y + self.tableView.bounds.height >= z * 0.8){
//                self.slider.setValue(1, animated: true)
//            }
//            else
//            {
//                self.slider.setValue(Float.init(y/z), animated: true)
//            }

//        else if scrollOffset + scrollViewHeight == scrollContentSizeHeight {
//            // then we are at the end
//            UIView.animate(withDuration: 2.0, animations: {self.slider.setValue(1.0, animated: false)})
//        }

//        print (z)
//        print ("*************")
//        let indexValue = tableView.indexPathForRow(at: CGPoint.init(x: 0, y: y))
//        print ("Moved Up")
//        print (indexValue?.row)
//        if (indexValue != nil){
//            self.slider.setValue(Float.init(Float.init((indexValue?.row)!) / 20.0), animated: false)
//        }
//        self.lastContentOffset = scrollView.contentOffset.y
//        let scrollViewHeight: Float = Float(scrollView.frame.size.height)
//        let scrollContentSizeHeight: Float = Float(scrollView.contentSize.height)
//        let scrollOffset: Float = Float(scrollView.contentOffset.y)
//        if scrollOffset == 0 {
//        // then we are at the top
//        self.slider.setValue(0.0, animated: false)
//         }
/*    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
 //        let y = scrollView.contentOffset.y
 //        print (y)
 //        print ("HEIGHTHRIGHT")
 //        let z = scrollView.contentSize.height
 //        print (z)
 //        print ("*************")
 //        //        if (y > 0){
 //        if (self.lastContentOffset > scrollView.contentOffset.y) {
 //            // move up
 //            let indexValue = tableView.indexPathForRow(at: CGPoint.init(x: 0, y: y))
 //            print ("Moved Up")
 //            print (indexValue?.row)
 //            if (indexValue != nil){
 //                self.slider.setValue(Float.init(Float.init((indexValue?.row)!) / 20.0), animated: false)
 //            }}
 //        else if (self.lastContentOffset < scrollView.contentOffset.y) {
 //            // move down
 //            print ("Moved down")
 //
 //            let indexValue = tableView.indexPathForRow(at: CGPoint.init(x: 0, y: y + self.tableView.bounds.size.height))
 //            print (indexValue?.row)
 //
 //            if (indexValue != nil){
 //                self.slider.setValue(Float.init(Float.init((indexValue?.row)!) / 20.0), animated: false)
 //
 //            }
 //
 //        }
 //        self.lastContentOffset = scrollView.contentOffset.y
 //        let scrollViewHeight: Float = Float(scrollView.frame.size.height)
 //        let scrollContentSizeHeight: Float = Float(scrollView.contentSize.height)
 //        let scrollOffset: Float = Float(scrollView.contentOffset.y)
 //        if scrollOffset == 0 {
 //            // then we are at the top
 //            self.slider.setValue(0.0, animated: false)
 //        }
 //        else if scrollOffset + scrollViewHeight == scrollContentSizeHeight {
 //            // then we are at the end
 //            self.slider.setValue(1.0, animated: false)
 //        }
 //    }*/
     
