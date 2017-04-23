import UIKit

let originalImage = UIImage(named: "sample")

// Process the image!
//convert image to rgba image
let myRGBA = RGBAImage(image: originalImage!)
//var myRGBA1 = RGBAImage(image: image!)
//var myRGBA2 = RGBAImage(image: image!)
//var myRGBA3 = RGBAImage(image: image!)
//var myRGBA4 = RGBAImage(image: image!)
//var myRGBA5 = RGBAImage(image: image!)
let avgRed = 118
let avgBlue = 83
let avgGreen = 98
func whiteTone( image1: UIImage, effect: Int) ->UIImage
{
    var color = RGBAImage(image: image1)
    for y in 0..<color!.height{
        for x in 0..<color!.width{
            let index=y*color!.width+x
            var pixel = color!.pixels[index]
//            var redDiff=Int(pixel.red)-avgRed
//            var blueDiff=Int(pixel.blue)-avgBlue
//            var greenDiff=Int(pixel.green)-avgGreen
            pixel.red=UInt8(max(0,min(255,Int(pixel.red)+effect)))
            color!.pixels[index]=pixel
            pixel.blue=UInt8(max(0,min(255,Int(pixel.blue)+effect)))
            color!.pixels[index]=pixel
            pixel.green=UInt8(max(0,min(255,Int(pixel.green)+effect)))
            color!.pixels[index]=pixel
            
        }
    }
    let whiteTone = color!.toUIImage()
    return (whiteTone)!
}

func enhanceRed( image1: UIImage, effect: Int) ->UIImage
{
     var color = RGBAImage(image: image1)
    for y in 0..<color!.height{
        for x in 0..<color!.width{
            let index=y*color!.width+x
            var pixel = color!.pixels[index]
          
                        let redDiff=Int(pixel.red)-avgRed
                        let blueDiff=Int(pixel.blue)-avgBlue
                        let greenDiff=Int(pixel.green)-avgGreen
            if (redDiff>0){
                            pixel.red=UInt8(max(0,min(255,Int(pixel.red)+effect)))
                            color!.pixels[index]=pixel
                        }
                        else if(blueDiff>0){
                            pixel.blue=UInt8(max(0,min(255,Int(pixel.blue)-effect)))
                            color!.pixels[index]=pixel
                        }
            
                        else if(greenDiff>0){
                            pixel.green=UInt8(max(0,min(255,Int(pixel.green)-effect)))
                            color!.pixels[index]=pixel
                        }

           
            
        }
    }
    let enhanceRed = color!.toUIImage()
    return (enhanceRed)!
}
func enhanceBlue( image1: UIImage, effect: Int) ->UIImage
{
     var color = RGBAImage(image: image1)
    for y in 0..<color!.height{
        for x in 0..<color!.width{
            let index=y*color!.width+x
            var pixel = color!.pixels[index]
            
            let redDiff=Int(pixel.red)-avgRed
            let blueDiff=Int(pixel.blue)-avgBlue
            let greenDiff=Int(pixel.green)-avgGreen
            if (redDiff>0){
                pixel.red=UInt8(max(0,min(255,Int(pixel.red)-effect)))
                color!.pixels[index]=pixel
            }
            else if(blueDiff>0){
                pixel.blue=UInt8(max(0,min(255,Int(pixel.blue)+effect)))
                color!.pixels[index]=pixel
            }
                
            else if(greenDiff>0){
                pixel.green=UInt8(max(0,min(255,Int(pixel.green)-effect)))
                color!.pixels[index]=pixel
            }
            
            
            
        }
    }
    let enhanceBlue = color!.toUIImage()
    return (enhanceBlue)!
}
func enhanceGreen( image1: UIImage, effect: Int) ->UIImage
{
     var color = RGBAImage(image: image1)
    for y in 0..<color!.height{
        for x in 0..<color!.width{
            let index=y*color!.width+x
            var pixel = color!.pixels[index]
            
            let redDiff=Int(pixel.red)-avgRed
            let blueDiff=Int(pixel.blue)-avgBlue
            let greenDiff=Int(pixel.green)-avgGreen
            if (redDiff>0){
                pixel.red=UInt8(max(0,min(255,Int(pixel.red)-effect)))
                color!.pixels[index]=pixel
            }
            else if(blueDiff>0){
                pixel.blue=UInt8(max(0,min(255,Int(pixel.blue)-effect)))
                color!.pixels[index]=pixel
            }
                
            else if(greenDiff>0){
                pixel.green=UInt8(max(0,min(255,Int(pixel.green)+effect)))
                color!.pixels[index]=pixel
            }
            
            
            
        }
    }
    let enhanceGreen = color!.toUIImage()
    return (enhanceGreen)!
}
func invertColor( image1: UIImage, effect: Int) ->UIImage
{
    var color = RGBAImage(image: image1)
    for y in 0..<color!.height{
        for x in 0..<color!.width{
            let index=y*color!.width+x
            var pixel = color!.pixels[index]
            
           
            
                pixel.red=UInt8(max(0,min(255,abs(Int(pixel.red)-effect))))
                color!.pixels[index]=pixel
           
            pixel.blue=UInt8(max(0,min(255,abs(Int(pixel.green)-effect))))
                color!.pixels[index]=pixel
         
            pixel.green=UInt8(max(0,min(255,abs(Int(pixel.blue)-effect))))
                color!.pixels[index]=pixel
            
            
            
            
        }
    }
    let invertColor = color!.toUIImage()
    return (invertColor)!
}

originalImage
let whiteImg=whiteTone(image1: originalImage!,effect: 30)
let redImg=enhanceRed(image1: whiteImg,effect: 30)
let blueImg=enhanceBlue(image1: redImg,effect: 15)
let greenImg=enhanceGreen(image1: blueImg,effect: 40)
let invertImage=invertColor(image1: greenImg, effect: 255)

