//
//  ViewController.swift
//  localizationSwift
//
//  Created by Md Ibrahim Hassan on 16/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//


import UIKit
import YoutubeSourceParserKit
import MediaPlayer

class ViewController: UIViewController {
    
    let moviePlayer = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePlayer.view.frame = view.frame
        view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        let youtubeURL = NSURL(string: "https://www.youtube.com/watch?v=swZJwZeMesk")!
        playVideoWithYoutubeURL(youtubeURL)
    }
    
    func playVideoWithYoutubeURL(url: NSURL) {
        Youtube.h264videosWithYoutubeURL(url, completion: { (videoInfo, error) -> Void in
            if let
                videoURLString = videoInfo?["url"] as? String,
                let videoTitle = videoInfo?["title"] as? String {
                self.moviePlayer.contentURL = NSURL(string: videoURLString)
            }
        })
    }
}

    /*
*/
//class ViewController: UIViewController
