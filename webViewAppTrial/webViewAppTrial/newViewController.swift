//
//  newViewController.swift
//  webViewAppTrial
//
//  Created by Md Ibrahim Hassan on 13/06/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
import WebKit

class newViewController: UIViewController,WKNavigationDelegate {
var webView : WKWebView!
    var urlArray : [String] = ["https://plus.google.com/106385653596093534317", "https://plus.google.com/105841814814170468703", "https://plus.google.com/116336205508637745270", "https://plus.google.com/+ShahRukhKhan", "https://www.linkedin.com/in/mdibrahimhassan/", "https://plus.google.com/+BeingSalmanKhan", "https://plus.google.com/107187467596960193415"]
    var i : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.applicationNameForUserAgent = @"Chrome Safari";
//        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero
//        configuration:wkWebConfig];
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.applicationNameForUserAgent = "Chrome Safari"
        webView = WKWebView(frame: self.view.frame, configuration: wkWebConfig)
        let myBlog = urlArray[6]
        let url = NSURL(string: myBlog)
        let request = NSURLRequest(url: url! as URL)
        
        // init and load request in webview.
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
//        i += 1
//        if (i < urlArray.count){
//            let myBlog = urlArray[i]
//            let url = NSURL(string: myBlog)
//            let request = NSURLRequest(url: url! as URL)
//            
//            // init and load request in webview.
//            webView.navigationDelegate = self
//            webView.load(request as URLRequest)
        
//        }
    }
}
