//
//  ViewController.swift
//  IHPlayer
//
//  Created by Md Ibrahim Hassan on 15/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let request = webView.request
        let url = request?.url
        self.textField.text = url?.path
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getDocumentsDirectory1.sharedInstance.logDirectoryPath()
        let musicArray = MusicArray()
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        MusicArray.getReferenceForDataSource(viewController: self)
 //       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
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
    /*
    var nameToSave : String = "test12.mp3"
    @IBAction func buttonAction(_ sender: UIButton) {
       print (self.textField.text!)
        WebService.sharedInstance.downloadVideo(text : self.textField.text!, completion: {(data) in
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "New Name",
                                              message: "Add a new name",
                                              preferredStyle: .alert)
                
                let saveAction = UIAlertAction(title: "Save",
                                               style: .default) {
                                                [unowned self] action in
                                                
                                                guard let textField = alert.textFields?.first,
                                                    let nameToSave = textField.text else {
                                                        return
                                                }
                                                self.nameToSave = nameToSave
                                                //                                            self.names.append(nameToSave)
                                                
                }
                
                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .default)
                
                alert.addTextField()
                
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.nameToSave)
                
                do {
                    try data.write(to: fileURL, options: .atomic)
                    getDocumentsDirectory1.sharedInstance.logDirectoryPath()
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        })
    }*/

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
        tableView.deselectRow(at: indexPath, animated: true)
        let playerItem = AVPlayerItem.init(url: (MusicArray.sharedInstance.filePath[indexPath.row]))
        MusicArray.sharedInstance.player = try AVPlayer(playerItem:playerItem)
        MusicArray.sharedInstance.player.volume = 1.0
        MusicArray.sharedInstance.player.play()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,forRowAt indexPath: IndexPath){
        if (editingStyle == .delete){
            MusicArray.sharedInstance.player.pause()
            getDocumentsDirectory1.sharedInstance.removeImage(itemName: MusicArray.sharedInstance.fileName[indexPath.row], fileExtension: "mp3")
            self.reloadData()
        }
    }
    func reloadData()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            self.tableView.reloadData()
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
}

class getDocumentsDirectory1: NSObject{
    static let sharedInstance = getDocumentsDirectory1()
    func logDirectoryPath (){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
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
        

}

class MusicArray: NSObject {
    static let sharedInstance = MusicArray()
    var player = AVPlayer()
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
