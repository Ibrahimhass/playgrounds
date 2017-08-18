//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"




func textToImage(drawText text: NSString, inImage size: CGSize) -> UIImage {
    //draw image first
    var image = UIImage.init()
    UIGraphicsBeginImageContext(size)
    image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    
    //text attributes
    let font=UIFont(name: "Helvetica-Bold", size: 32)!
    let text_style=NSMutableParagraphStyle()
    text_style.alignment=NSTextAlignment.center
    let text_color=UIColor.black
    let attributes=[NSFontAttributeName:font, NSParagraphStyleAttributeName:text_style, NSForegroundColorAttributeName:text_color]
    
    //vertically center (depending on font)
    let text_h=font.lineHeight
    let text_y=(size.height-text_h)/2
    let text_rect=CGRect(x: 0, y: text_y, width: size.width, height: text_h)
    text.draw(in: text_rect.integral, withAttributes: attributes)
    let result=UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result!
}

textToImage(drawText: "", inImage: CGSize.init(width: 200, height: 200))
