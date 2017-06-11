//
//  ViewController.swift
//  newProject
//
//  Created by Md Ibrahim Hassan on 14/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let path = UIBezierPath()
//        
//        // starting point for the path (bottom left)
//        path.move(to: CGPoint(x: 2, y: 26))
//        
//        // *********************
//        // ***** Left side *****
//        // *********************
//        
//        // segment 1: line
//        path.addLine(to: CGPoint(x: 2, y: 15))
//        
//        // segment 2: curve
//        path.addCurve(to: CGPoint(x: 0, y: 12), // ending point
//            controlPoint1: CGPoint(x: 2, y: 14),
//            controlPoint2: CGPoint(x: 0, y: 14))
//        
//        // segment 3: line
//        path.addLine(to: CGPoint(x: 0, y: 2))
//        
//        // *********************
//        // ****** Top side *****
//        // *********************
//        
//        // segment 4: arc
//        path.addArc(withCenter: CGPoint(x: 2, y: 2), // center point of circle
//            radius: 2, // this will make it meet our path line
//            startAngle: CGFloat(M_PI), // π radians = 180 degrees = straight left
//            endAngle: CGFloat(3*M_PI_2), // 3π/2 radians = 270 degrees = straight up
//            clockwise: true) // startAngle to endAngle goes in a clockwise direction
//        
//        // segment 5: line
//        path.addLine(to: CGPoint(x: 8, y: 0))
//        
//        // segment 6: arc
//        path.addArc(withCenter: CGPoint(x: 8, y: 2),
//                    radius: 2,
//                    startAngle: CGFloat(3*M_PI_2), // straight up
//            endAngle: CGFloat(0), // 0 radians = straight right
//            clockwise: true)
//        
//        // *********************
//        // ***** Right side ****
//        // *********************
//        
//        // segment 7: line
//        path.addLine(to: CGPoint(x: 10, y: 12))
//        
//        // segment 8: curve
//        path.addCurve(to: CGPoint(x: 8, y: 15), // ending point
//            controlPoint1: CGPoint(x: 10, y: 14),
//            controlPoint2: CGPoint(x: 8, y: 14))
//        
//        // segment 9: line
//        path.addLine(to: CGPoint(x: 8, y: 26))
//        
//        // *********************
//        // **** Bottom side ****
//        // *********************
//        
//        // segment 10: line
//        path.close() // draws the final line to close the path
//        
        
        
        /*    UIView *myView = [[UIView alloc]initWithFrame:self.view.frame];
         UIBezierPath *linePath = [UIBezierPath bezierPath];
         
         [linePath moveToPoint:CGPointMake(points[0].x, points[0].y)];
         [linePath addLineToPoint:CGPointMake(points[1].x, points[1].y)];
         [linePath addLineToPoint:CGPointMake(points[2].x, points[2].y)];
         [linePath addLineToPoint:CGPointMake(points[3].x, points[3].y)];
         [linePath closePath];
         CAShapeLayer *shape = [[CAShapeLayer alloc]init];
         [shape setPath:linePath.CGPath];
         myView.layer.mask=shape;
         myView.backgroundColor = [UIColor redColor];
         [self.view addSubview:myView];
         79.583483072916664, 54.148963562011716}";  // top left
         1 = "NSPoint: {274.96375, 30.877176879882814}"; // top right
         2 = "NSPoint: {306.15565104166666, 357.91370518493653}"; // bottom right
         3 = "NSPoint: {77.101464843749994, 363.47374218750002}"; /
         
         */

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 160.0, y: 160.0))
        path.addCurve(to: CGPoint.init(x: 160.0, y: 160.0), controlPoint1: CGPoint.init(x: 200.0, y: 200.0), controlPoint2: CGPoint.init(x: 250.0, y: 250.0))
        
        path.addLine(to: CGPoint(x:274.96375, y:30.877176879882814))
        path.addLine(to: CGPoint(x:306.15565104166666, y:357.91370518493653))
//        path.addLine(to: CGPoint(x:77.101464843749994 , y:363.47374218750002))
        
        path.close()
        
        
        let shape = CAShapeLayer.init()
        shape.path = path.cgPath
        self.view.layer.mask = shape
        self.view.backgroundColor = .red
        
        
        
        
        
//        let imageView = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(50), width: CGFloat(320), height: CGFloat(320)))
//        view.addSubview(imageView)
//        let image = UIImage(named: "Dubai-Photos-Images-Travel-Tourist-Images-Pictures-800x600.jpg")
//        imageView.image = circularScaleAndCropImage(UIImage(named: "Dubai-Photos-Images-Travel-Tourist-Images-Pictures-800x600.jpg")!, frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(100)))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func circularScaleAndCropImage(_ image: UIImage, frame: CGRect) -> UIImage {
        // This function returns a newImage, based on image, that has been:
        // - scaled to fit in (CGRect) rect
        // - and cropped within a circle of radius: rectWidth/2
        //Create the bitmap graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: CGFloat(frame.size.width), height: CGFloat(frame.size.height)), false, 0.0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        //Get the width and heights
        let imageWidth: CGFloat = image.size.width
        let imageHeight: CGFloat = image.size.height
        let rectWidth: CGFloat = frame.size.width
        let rectHeight: CGFloat = frame.size.height
        //Calculate the scale factor
        let scaleFactorX: CGFloat = rectWidth / imageWidth
        let scaleFactorY: CGFloat = rectHeight / imageHeight
        //Calculate the centre of the circle
        let imageCentreX: CGFloat = rectWidth / 2
        let imageCentreY: CGFloat = rectHeight / 2
        // Create and CLIP to a CIRCULAR Path
        // (This could be replaced with any closed path if you want a different shaped clip)
        let radius: CGFloat = rectWidth / 2
        context?.beginPath()
        context?.addArc(center: CGPoint(x: imageCentreX, y: imageCentreY), radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(2 * Float.pi), clockwise: false)
        context?.closePath()
        context?.clip()
        //Set the SCALE factor for the graphics context
        //All future draw calls will be scaled by this factor
        context?.scaleBy(x: scaleFactorX, y: scaleFactorY)
        // Draw the IMAGE
        let myRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: imageWidth, height: imageHeight)
        image.draw(in: myRect)
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

