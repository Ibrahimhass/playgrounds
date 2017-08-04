//
//  ViewController.swift
//  IHImageCropper
//
//  Created by Md Ibrahim Hassan on 04/08/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imageView = UIImageView()
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
imageView.frame = CGRect.init(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        let tapgesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.loadImage(sender:)))
        tapgesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapgesture)
    }

    func loadImage(sender : UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func cropAndSave(_ sender: UIButton) {
//        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
//        let offSet = scrollView.contentOffset
//        UIGraphicsGetCurrentContext()
//        cgcontexttranslatectm
        let factor = scrollView.zoomScale
        let x = (scrollView.contentOffset.x + scrollView.frame.origin.x - imageView.frame.origin.x) * UIScreen.main.scale / factor
        print (x)
        let y = (scrollView.contentOffset.y) * UIScreen.main.scale / factor
        print (y)
        let width = scrollView.frame.size.width * UIScreen.main.scale
        print (width)
        let height = scrollView.frame.size.height * UIScreen.main.scale
        print (height)
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: CGRect.init(x: x, y: y, width: width, height: height))
        let croppedImage = UIImage(cgImage: croppedCGImage!)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        imageView.image = image
        imageView.frame = CGRect.init(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        imageView.contentMode = .center
        scrollView.contentSize = (image?.size)!
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.5
        scrollView.zoomScale = 0.5
        self.centerScrollViewContents()
        picker.dismiss(animated: true, completion: nil)
        
    }
    var scrollToSnapCode : Bool = false
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentFrame = imageView.frame
        
        if (contentFrame.size.width < boundsSize.width){
            contentFrame.origin.x = (boundsSize.width - contentFrame.size.width) / 2
        }
        else {
            contentFrame.origin.x = 0
        }
        if (contentFrame.size.height < boundsSize.height){
            contentFrame.origin.y = (boundsSize.height - contentFrame.size.height) / 2
        }
        else {
            contentFrame.origin.y = 0
            if(!scrollToSnapCode){
                scrollView.scrollRectToVisible(CGRect.init(x: 0, y: 400, width: 320, height: 320), animated: true)
                scrollToSnapCode = true
            }
        }
        imageView.frame = contentFrame
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContents()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

