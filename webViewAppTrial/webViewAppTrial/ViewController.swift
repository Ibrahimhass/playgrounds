//
//  ViewController.swift
//  webViewAppTrial
//
//  Created by Md Ibrahim Hassan on 11/06/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
//    var webView: WKWebView!
    
//    func loadWebViewWithCustomJavaScript() {
//        //Create Preferences
//        let preferences = WKPreferences()
//        preferences.javaScriptEnabled = true
//        //Initialise javascript file with user content controller and configuration
//        let configuration = WKWebViewConfiguration()
////        let scriptURL =    Bundle.main.path(forResource: "lib", ofType: "js")
////        var scriptContent = ""
////        do {
////            scriptContent = try String(contentsOfFile: scriptURL!, encoding: String.Encoding.utf8)
////        } catch{
////            print("Cannot Load File")
////        }
////        let script = WKUserScript(source: scriptContent, injectionTime: .atDocumentStart, forMainFrameOnly: true)
////        configuration.userContentController.addUserScript(script)
////        configuration.preferences = preferences
//        //Create WebView instance
//        
//        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), configuration: configuration)
//        view.addSubview(webView)
//        //Finally load the url
//        let path = Bundle.main.path(forResource: "app", ofType: "html")!
//        let url = URL(fileURLWithPath: path)
//        let urlRequest = URLRequest(url: url)
//        webView.load(urlRequest)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "app", ofType: "html")!
        let url = URL(fileURLWithPath: path)
        let request = URLRequest(url: url)
        webView.loadRequest(request)
//        self.loadWebViewWithCustomJavaScript()
        webView.scalesPageToFit = true
    }
//func loadJava()
//{
//    let path = Bundle.main.path(forResource: "app", ofType: "js")
//    let url = URL(fileURLWithPath: path!)
//    do {
//        let text2 = try String(contentsOf: url, encoding: String.Encoding.utf8)
//        print (text2)
//        
//        webView.stringByEvaluatingJavaScript(from: text2)
//    }
//    catch {
//        print ("error occured")}
//    }
//    }
//    func webViewDidFinishLoad(_ webView: UIWebView){
//            
// print ("Loading ended")
//    }
}
