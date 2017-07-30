//
//  ViewController.swift
//  IHPlayer
//
//  Created by Md Ibrahim Hassan on 15/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

var index123 : Int = 0
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let request = webView.request
        let url = request?.url
        self.textField.text = url?.path
    }
    
    @IBOutlet weak var sliderOutput: UISlider!
    
    @IBAction func sliderAction(_ sender: Any) {
        if let player = self.player{
            let duration : CMTime = (player.currentItem!.duration)
            let seconds : Float64 = CMTimeGetSeconds(duration)
            let maxTime : Float = Float(seconds) * (sender as AnyObject).value
            self.timePlayed.text = ""
            let time : CMTime = CMTime.init(seconds: Double(maxTime) , preferredTimescale: CMTimeScale.init(1))
            player.seek(to: time)
            self.timePlayed.text = String(maxTime)
        }
    }
    
    
    var updater : CADisplayLink! = nil
    
    var player: AVPlayer?
    var nextIndexToPlay : Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        getDocumentsDirectory1.sharedInstance.logDirectoryPath()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.playw), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    func playw(){
        //do here whatever you want to do
        self.nextIndexToPlay += 1

        let playerItem = AVPlayerItem.init(url: (MusicArray.sharedInstance.filePath[nextIndexToPlay]))
        self.player = try AVPlayer(playerItem:playerItem)
        self.player?.volume = 1.0
        self.player?.play()
        self.nameFile.text = MusicArray.sharedInstance.fileName[nextIndexToPlay]
    }

    
    @IBAction func pausePlay(_ sender: UIButton) {
        print ("Button Pressed")
        
        if (self.player?.rate != 0)
        {
            self.player?.pause()
        }
        else {
            self.player?.play()
        }
    }
    
    
    
    var savedFileNameAndTime : [String : CMTime] = [:]
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameFile: UILabel!
    @IBOutlet weak var timePlayed: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = self.textField.text{
            let url = URL.init(string: text)
            if let url = url {
                let request = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 1000.0)
                self.webView.loadRequest(request)
            }
        }
    }
    


    // MARK: - TableView Delegate and Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MusicArray.sharedInstance.filePath.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")! as! tableViewCell12

        cell.songName?.text = MusicArray.sharedInstance.fileName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let player = self.player{
//            let alert = UIAlertController(title: "Notice", message: "A file is already playing", preferredStyle: .alert)
//            let saveAction = UIAlertAction(title: "Save Time", style: .default) {
//                [unowned self] action in
//                self.savedFileNameAndTime[MusicArray.sharedInstance.fileName[indexPath.row]] = player.currentTime()
//                print (self.savedFileNameAndTime)
//                UserDefaults.standard.set(self.savedFileNameAndTime as [String:CMTime], forKey: "pendingItems")
//                print ("Save Current Time and fileName")
//            }
//            
//            let cancelAction = UIAlertAction(title: "Cancel",
//                                             style: .default)
//            
//            alert.addAction(saveAction)
//            alert.addAction(cancelAction)
//            self.present(alert, animated: true)
//
//        }
        self.nextIndexToPlay = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.nameFile.text = MusicArray.sharedInstance.fileName[indexPath.row]
   
//        updater = CADisplayLink(target: self, selector: Selector("trackAudio"))
//        updater.frameInterval = 1
//        updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
//        let playerItem = AVPlayerItem.init(url: (MusicArray.sharedInstance.filePath[indexPath.row]))
//        myUrl = MusicArray.sharedInstance.filePath[indexPath.row]
        index123 = indexPath.row
        self.performSegue(withIdentifier: "musicViewSegue", sender: self)
//        self.player = try AVPlayer(playerItem:playerItem)
//        print (self.player?.currentTime() ?? 0.0)
//        self.player?.volume = 1.0
//        self.player?.play()
    }
    
    func trackAudio() {
        let duration : CMTime = (self.player?.currentItem!.duration)!
        let seconds : Float64 = CMTimeGetSeconds(duration)
        let maxTime : Float = Float(seconds)
        let float64Time : Float64 = CMTimeGetSeconds((self.player?.currentTime())!)
        let currentTime = Float(float64Time)
        self.totalTime.text = String(maxTime)
        self.timePlayed.text = String(currentTime)
        self.sliderOutput.value = currentTime / maxTime
//        let videoDurationSeconds = CMTimeGetSeconds(currentTime)
    
        
//        var normalizedTime = Float(Double(self.player?.currentTime * 100.0) / player.duration)
//        print (normalizedTime)
    }
    
    
    @IBAction func completedTracks(_ sender: Any) {
        
    }
    @IBAction func pendingTracks(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {action in
            //            //handle delete
            self.player?.pause()
            getDocumentsDirectory1.sharedInstance.removeImage(itemName: MusicArray.sharedInstance.fileName[indexPath.row], fileExtension: "mp3")
            self.reloadData()
            
        }
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            getDocumentsDirectory1.sharedInstance.renameImage(itemName: MusicArray.sharedInstance.fileName[indexPath.row], fileExtension: "mp3", renameTo: nameToSave)
            self.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .default)
            
            alert.addTextField()
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        return [editAction,deleteAction]
    }

    func reloadData()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            self.tableView.reloadData()
        })
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.sliderOutput)
            print (currentPoint)
            // do something with your currentPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.sliderOutput)
            print (currentPoint)
            // do something with your currentPoint
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.sliderOutput)
            print (currentPoint)
            // do something with your currentPoint
        }
    }
}

class getDocumentsDirectory1: NSObject{
    static let sharedInstance = getDocumentsDirectory1()
    func logDirectoryPath (){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
//            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
            print("mp3 urls:",mp3Files)
            let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
            print("mp3 list:", mp3FileNames)
            MusicArray.sharedInstance.getValues(filePath: mp3Files, fileName: mp3FileNames)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    func removeImage(itemName:String, fileExtension: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let fileManager = FileManager.default
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            guard let dirPath = paths.first else {
                return
            }
            let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
            do {
                try fileManager.removeItem(atPath: filePath)
                self.logDirectoryPath()
            } catch let error as NSError {
                print(error.debugDescription)
            }}
        }
    func renameImage(itemName: String, fileExtension: String, renameTo: String){
        DispatchQueue.global(qos: .userInitiated).async {
            let fileManager = FileManager.default
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            guard let dirPath = paths.first else {
                    return
                }
            let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
            let renamePath = "\(dirPath)/\(renameTo).\(fileExtension)"
            do {
                try fileManager.moveItem(atPath: filePath, toPath: renamePath)
                self.logDirectoryPath()
            } catch let error as NSError {
                print(error.debugDescription)
            }}
    }

    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        print (touch)
        }
//        super.touchesMoved(touches, with: event)
    }
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            print (touch)
        }
//        super.touchesEnded(touches, with: event)
    }
}

class MusicArray: NSObject {
    static let sharedInstance = MusicArray()
    var fileName : [String] = []
    var filePath : [URL] = []
    override init() {
        super.init()
    }
    func getValues(filePath : [URL], fileName : [String]){
        self.filePath = filePath
        self.fileName = fileName
    }
    }


/*class WebService : NSObject{
    static let sharedInstance = WebService()
    func downloadYouTubeAudio(videoURL : String, completion : @escaping (Data) -> Void ){
        let url = URL.init(string: videoURL)
        let sessionConfig = URLSessionConfiguration.default
        let request = NSMutableURLRequest.init(url: url!)
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest){
            data, response, error in
            if (error == nil) {
                if let response = response as? HTTPURLResponse {
                    print("response=\(response)")
                    if response.statusCode == 200 {
                        if data != nil {
                            completion(data!)
                        }
                    }
                }
            }
            else {
                print("Failure: \(error!.localizedDescription)");
            }
        }
        task.resume()
    }
    
    func downloadVideo(text : String, completion: @escaping (Data) -> Void ){
        let url = URL.init(string: text)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest.init(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest)
        {
         data, response, error in
            if (error == nil) {
                if let response = response as? HTTPURLResponse {
                    print("response=\(response)")
                    if response.statusCode == 200 {
                        if data != nil {
                            
                                completion(data!)
                            
                        }
                    }
                }
            }
            else {
                print("Failure: \(error!.localizedDescription)");
            }
        }
        task.resume()
    }
}
*/
