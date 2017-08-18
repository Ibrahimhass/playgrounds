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
import Accelerate

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
        bombSoundEffect.rate = 1.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var points:[CGFloat] = []

    @IBAction func buttonAction(_ sender: Any){
        
       }
    func getPath(){
        var url : URL?
        if Platform.isSimulator {
        
        let path = Bundle.main.path(forResource: "01 - Battlefield 3 Main Theme.mp3", ofType:nil)!
        url = URL(fileURLWithPath: path)
        }
        else
        {
            url = MusicArray.sharedInstance.filePath[index123]
        }
//        var arrayFloatValues:[Float] = []
//        let file = try! AVAudioFile(forReading: url!)
//        let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: file.fileFormat.channelCount, interleaved: false)
//        let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: UInt32(file.length))
//        try! file.read(into: buf)
//        print (arrayFloatValues.count)
//        var processingBuffer = [Float](repeating: 0.0,
//                                       count: Int(arrayFloatValues.count))
//        let sampleCount = vDSP_Length(arrayFloatValues.count)
//        arrayFloatValues = Array(UnsafeBufferPointer(start: buf.floatChannelData?[0], count:Int(buf.frameLength)))
//        let samplesPerPixel = Int(CGFloat(sampleCount) / 320)
//        let filter = [Float](repeating: 1.0 / Float(samplesPerPixel),
//                             count: Int(samplesPerPixel))
//        let downSampledLength = Int(arrayFloatValues.count / samplesPerPixel)
//        var downSampledData = [Float](repeating:0.0,
//                                      count:downSampledLength)
//        vDSP_desamp(processingBuffer,
//                    vDSP_Stride(samplesPerPixel),
//                    filter, &downSampledData,
//                    vDSP_Length(downSampledLength),
//                    vDSP_Length(samplesPerPixel))
        
        // print(" DOWNSAMPLEDDATA: \(downSampledData.count)")
        
        //convert [Float] to [CGFloat] array
//        points = downSampledData.map{CGFloat($0)}
        
        /* let samplesPerPixel = Int(CGFloat(sampleCount) / 24000)
         let filter = [Float](repeating: 1.0 / Float(samplesPerPixel),
         count: Int(samplesPerPixel))
         let downSampledLength = Int(readFile.arrayFloatValues.count / samplesPerPixel)
         var downSampledData = [Float](repeating:0.0,
         count:downSampledLength)
         vDSP_desamp(processingBuffer,
         vDSP_Stride(samplesPerPixel),
         filter, &downSampledData,
         vDSP_Length(downSampledLength),
         vDSP_Length(samplesPerPixel))*/
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url!)
            bombSoundEffect = sound
            bombSoundEffect.enableRate = true
            bombSoundEffect.isMeteringEnabled = true
            bombSoundEffect.delegate = self
            sound.play()
            updater1 = CADisplayLink(target: self, selector: #selector(audioVisualiserViewController.trackAudio))
            updater1.frameInterval = Int(1)
            updater1.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        } catch {
            // couldn't load file :(
        }
    }
    var dataArray : [Float] = []

    var totalCount : Int = 0
    func trackAudio() {
        bombSoundEffect.updateMeters()
        let dBLogValue : Float = bombSoundEffect.averagePower(forChannel: 0)
        dataArray.append(dBLogValue)
        
//        if (dataArray.count % 2 == 0 && dataArray.count != 0){
            let twoDecimalPlaces = String(format: "%.2f", dataArray[totalCount])
        totalCount += 1
//            let twoDecimalPlaces11 = String(format: "%.2f", dataArray[0])
//            let twoDecimalPlaces111 = String(format: "%.2f", dataArray[1])
//            print (abs(Int(Float(twoDecimalPlaces)!) * 2))
//            print (abs(Int(Float(twoDecimalPlaces1)!) * 2))
//            self.drawLineFromPoint(start: CGPoint.init(x: totalCount - 1, y: Int(abs((Float(twoDecimalPlaces)!) * Float(self.myView.frame.size.height * 0.1)))), toPoint: CGPoint.init(x: totalCount, y: Int(abs((Float(twoDecimalPlaces1)!)  * Float(self.myView.frame.size.height * 0.1)))), ofColor: .white, inView: self.myView)
        
        
        
//        self.drawLineFromPoint(start: self.generatePoints1(dBVal: twoDecimalPlaces), toPoint: self.generatePoint2(dBVal: twoDecimalPlaces), ofColor: .white, inView: self.myView)
//            self.drawLineFromPoint(start: CGPoint.init(x: totalCount - 1, y: Int(abs((Float(twoDecimalPlaces11)!) * Float(self.myView.frame.size.height * 0.1))) + 100), toPoint: CGPoint.init(x: totalCount, y: Int(abs((Float(twoDecimalPlaces111)!)  * Float(self.myView.frame.size.height * 0.1))) + 100), ofColor: .red, inView: self.myView)
//            dataArray.removeAll()
//            dataArray1.removeAll()
//        }
        self.generatePoints1(dBVal: twoDecimalPlaces)
    }
    var xPoint : CGFloat = 0.0
    private func generatePoints1(dBVal : String){
        xPoint += 1.0
        let aPath = UIBezierPath()
        aPath.lineWidth = 2.0
        let floatVal : Float = Float(dBVal)!
        var intVal = floatVal
//        print (intVal)
        if (intVal < -10){
//            let value = CGFloat(1 - CGFloat(abs(intVal))/CGFloat(200.0))
//            if (value != -1){
//                let value1 = CGFloat(-10.0) + value
//                intVal = Float(value1)
            intVal = -10.91
            }
//        }
//        print(10 - abs(intVal))
        let fromYPoint : CGFloat = (self.myView.contentSize.height / 23) * CGFloat(abs(intVal))
        let toYPoint : CGFloat = (self.myView.contentSize.height / 23) * CGFloat(23 - abs(intVal))
        aPath.move(to: CGPoint(x:xPoint , y: fromYPoint))
        aPath.addLine(to: CGPoint(x: xPoint, y: toYPoint))
        xPoint += 1.0
//        aPath.close()
        //UIColor.orange.set()
        //aPath.stroke(with: CGBlendMode.normal, alpha: 0.5)
        //aPath.fill()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = aPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 1.0
        self.myView.layer.addSublayer(shapeLayer)
        self.myView.contentSize.width = xPoint
        self.myView.contentSize.height = self.myView.frame.size.height


        /*{
         self.convertToPoints()
         var f = 0
         print("draw")
         
         
         
         
         
         // print(readFile.points)
         for _ in readFile.points{
         //separation of points
         var x:CGFloat = 2.5
         aPath.move(to: CGPoint(x:aPath.currentPoint.x + x , y:aPath.currentPoint.y ))
         
         //Y is the amplitude
         aPath.addLine(to: CGPoint(x:aPath.currentPoint.x  , y:aPath.currentPoint.y - (readFile.points[f] * 70) - 1.0))
         
         aPath.close()
         
         //print(aPath.currentPoint.x)
         x += 1
         f += 1
         }
         
         //If you want to stroke it with a Orange color
         UIColor.orange.set()
         aPath.stroke()
         //If you want to fill it as well
         aPath.fill()
         
         
         f = 0
         aPath2.move(to: CGPoint(x:0.0 , y:rect.height/2 ))
         
         //Reflection of waveform
         for _ in readFile.points{
         var x:CGFloat = 2.5
         aPath2.move(to: CGPoint(x:aPath2.currentPoint.x + x , y:aPath2.currentPoint.y ))
         
         //Y is the amplitude
         aPath2.addLine(to: CGPoint(x:aPath2.currentPoint.x  , y:aPath2.currentPoint.y - ((-1.0 * readFile.points[f]) * 50)))
         
         // aPath.close()
         aPath2.close()
         
         //print(aPath.currentPoint.x)
         x += 1
         f += 1
         }
         
         //If you want to stroke it with a Orange color with alpha2
         UIColor.orange.set()
         aPath2.stroke(with: CGBlendMode.normal, alpha: 0.5)
         //   aPath.stroke()
         
         //If you want to fill it as well
         aPath2.fill()
         }*/
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
//        sendMessage.sharedInstance.dataArray2 = dataArray1
//        sendMessage.sharedInstance.createCSV()
        
        
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
