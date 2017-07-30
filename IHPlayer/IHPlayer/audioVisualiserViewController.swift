//
//  audioVisualiserViewController.swift
//  IHPlayer
//
//  Created by Md Ibrahim Hassan on 26/07/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//  (segueName)musicViewSegue
import MessageUI

import UIKit
import AVFoundation
import CoreMedia

class audioVisualiserViewController: UIViewController, AVAudioPlayerDelegate, MFMailComposeViewControllerDelegate {

    var bombSoundEffect: AVAudioPlayer!

    var updater1 : CADisplayLink! = nil

    @IBOutlet var myView: UIScrollView!
    
    struct Platform {
        static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPath()
//        let str = self.textField?.text!
        bombSoundEffect.rate = 1.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonAction(_ sender: Any){
        
       }
    func getPath(){
        var url : URL?
        if Platform.isSimulator {
            let path = Bundle.main.path(forResource: "01 - Battlefield 3 Main Theme.mp3", ofType:nil)!
        url = URL(fileURLWithPath: path)        }
        else {
            url = MusicArray.sharedInstance.filePath[index123]
            
        }
        do {
            let sound = try AVAudioPlayer(contentsOf: url!)
            bombSoundEffect = sound
            bombSoundEffect.enableRate = true
            bombSoundEffect.isMeteringEnabled = true
            bombSoundEffect.delegate = self
            sound.play()
            updater1 = CADisplayLink(target: self, selector: #selector(audioVisualiserViewController.trackAudio))
            updater1.frameInterval = Int(4)
            updater1.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        } catch {
            // couldn't load file :(
        }
    }
    var dataArray : [Float] = []
    var dataArray1 : [Float] = []

    var totalCount : Int = 0
    func trackAudio() {
        bombSoundEffect.updateMeters()
        let dBLogValue : Float = bombSoundEffect.averagePower(forChannel: 0)
        let dBLogValue1 : Float = bombSoundEffect.averagePower(forChannel: 1)
//        let linearScale = powf(10.0, dBLogValue) * 20.0
        dataArray.append(dBLogValue)
        dataArray1.append(dBLogValue1)
        
//        if (dataArray.count % 2 == 0 && dataArray.count != 0){
            let twoDecimalPlaces = String(format: "%.2f", dataArray[totalCount])
            let twoDecimalPlaces1 = String(format: "%.2f", dataArray1[totalCount])
        totalCount += 1
//            let twoDecimalPlaces11 = String(format: "%.2f", dataArray[0])
//            let twoDecimalPlaces111 = String(format: "%.2f", dataArray[1])
//            print (abs(Int(Float(twoDecimalPlaces)!) * 2))
//            print (abs(Int(Float(twoDecimalPlaces1)!) * 2))
//            self.drawLineFromPoint(start: CGPoint.init(x: totalCount - 1, y: Int(abs((Float(twoDecimalPlaces)!) * Float(self.myView.frame.size.height * 0.1)))), toPoint: CGPoint.init(x: totalCount, y: Int(abs((Float(twoDecimalPlaces1)!)  * Float(self.myView.frame.size.height * 0.1)))), ofColor: .white, inView: self.myView)
        
        
        
        self.drawLineFromPoint(start: self.generatePoints1(dBVal: twoDecimalPlaces), toPoint: self.generatePoint2(dBVal: twoDecimalPlaces), ofColor: .white, inView: self.myView)
        self.drawLineFromPoint(start: self.generatePoints1(dBVal: twoDecimalPlaces1), toPoint: self.generatePoint2(dBVal: twoDecimalPlaces1), ofColor: .white, inView: self.myView)
//            self.drawLineFromPoint(start: CGPoint.init(x: totalCount - 1, y: Int(abs((Float(twoDecimalPlaces11)!) * Float(self.myView.frame.size.height * 0.1))) + 100), toPoint: CGPoint.init(x: totalCount, y: Int(abs((Float(twoDecimalPlaces111)!)  * Float(self.myView.frame.size.height * 0.1))) + 100), ofColor: .red, inView: self.myView)
//            dataArray.removeAll()
//            dataArray1.removeAll()
//        }
    }
    
    private func generatePoints1(dBVal : String) -> CGPoint {
        let floatVal : Float = Float(dBVal)!
        var intVal = Int (floatVal)
        print (intVal)

        if (intVal < -25){
            intVal = -25
        }
        print(25 - abs(intVal))
        let pointAboveBaseLine : CGFloat = (self.myView.frame.size.height / 50) * CGFloat(25 - abs(intVal))
        let absoluteY : CGFloat = self.myView.frame.origin.y + self.myView.bounds.height / 2 + pointAboveBaseLine
        let finalPoint1 = CGPoint.init(x: CGFloat(totalCount - 1), y: absoluteY)
//        print ("Channel 1: \(finalPoint1.y)")
        return finalPoint1
    }
    private func generatePoint2(dBVal : String) -> CGPoint {
        let floatVal : Float = Float(dBVal)!
        var intVal = Int (floatVal)
        if (intVal < -25){
            intVal = -25
        }
        print(25 - abs(intVal))
        let pointBelowLine : CGFloat = (self.myView.bounds.height / 50) * CGFloat(25 - abs(intVal))
        let absoluteY : CGFloat = self.myView.frame.origin.y + self.myView.frame.size.height / 2 - pointBelowLine
        let finalPoint1 = CGPoint.init(x: CGFloat(totalCount + 1), y: absoluteY)
        print ("Channel2 : \(finalPoint1.y)")
        return finalPoint1
    }
    
    
    var previousStartPoint : CGPoint?
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        //design the path
        var path = UIBezierPath()
        if (previousStartPoint == nil){
            path.move(to: start)
        }
        else {
            path.move(to: previousStartPoint!)
        }
//        path.move(to: CGPoint.init(x: start.x, y: self.myView.frame.origin.y + self.myView.frame.size.height / 2))
//        path.addLine(to: start)
        path.addLine(to: end)
//        print(end)
//        previousStartPoint = start
        //design path in layer
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        self.myView.layer.addSublayer(shapeLayer)
        self.myView.contentSize.width = end.x
        if (end.x > self.myView.frame.size.width){
//            self.myView.setContentOffset(CGPoint.init(x: end.x - self.myView.bounds.width, y: self.myView.bounds.height / 2.0), animated: false)
        }
//        print(end.y)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //You can stop the audio
//        print (dataArray)
//        print (dataArray1)
        sendMessage.sharedInstance.viewControllerReference = self
        sendMessage.sharedInstance.dataArray1 = dataArray
        sendMessage.sharedInstance.dataArray2 = dataArray1
        sendMessage.sharedInstance.createCSV()
        
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
//        print (result)
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var textField: UITextField!
    @IBAction func setRate(_ sender: Any) {
        self.getPath()
        let str = self.textField?.text!
        bombSoundEffect.rate = Float(str!)!

    }
}
class CustomView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    func updateView (fromPoint : CGPoint, toPoint : CGPoint){
        
    }
}


class sendMessage: NSObject {
    static let sharedInstance = sendMessage()
    var mailString = NSMutableString()

    var viewControllerReference : audioVisualiserViewController?
    private var channels : Int = 0
    var dataArray1 : [Float] = []
    var dataArray2 : [Float] = []

    override init() {
        print ("Initialised")
    }
    
    func createCSV(){
        let fileName = "Bands.csv"
        var csvText = "Band1,Band2\n"
        for i in 0 ..< self.dataArray1.count{
        let newLine = "\(dataArray1[i]),\(dataArray2[i])\n"
        csvText.append(newLine)
        }
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
        try csvText.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            let emailController = MFMailComposeViewController()
            if (viewControllerReference != nil){
                emailController.mailComposeDelegate = viewControllerReference!
                emailController.setSubject("CSV File")
                emailController.setMessageBody("", isHTML: false)
                do {
                    let data = try Data.init(contentsOf: fileURL)
                    emailController.addAttachmentData(data, mimeType: "text/csv", fileName: "Bands.csv")
                }
                catch {
                    print(error)
                }
                if MFMailComposeViewController.canSendMail() {
                    viewControllerReference!.present(emailController, animated: true, completion: nil)
                }
        }
    }
        catch {
            print(error)
        }
    }
}
