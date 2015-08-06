//
//  FTGradientLabel.swift
//  FTGradientLabelDemo
//
//  Created by Bill on 15/8/4.
//  Copyright (c) 2015年 Fittime. All rights reserved.
//

import UIKit



class FTGradientLabel: UILabel {
    var shadowBlur:CGFloat!
    //var innerShadowOffset:CGSize!
    var innerShadowColor:UIColor!
    var gradientStartColor:UIColor!
    var gradientEndColor:UIColor!
    var gradientColors:NSArray!
    var gradientStartPoint:CGPoint!
    var gradientEndPoint:CGPoint!
    var overSampling:Int!
    var textInsets:UIEdgeInsets!
    
    var minSamples:Int!
    var maxSamples:Int!
    
    func setDefaults()
    {
        gradientStartPoint = CGPointMake(0.5, 0.0)
        gradientEndPoint = CGPointMake(0.5, 0.0)
        minSamples = 1
        maxSamples = 1
        overSampling = minSamples
        if(UIScreen.instancesRespondToSelector(Selector("scale")))
        {
            minSamples = Int(UIScreen.mainScreen().scale)
            maxSamples = 32
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        userInteractionEnabled = false
        setDefaults()
        //setInitialValues()
    }
    
    convenience init(frame:CGRect, colors: UIColor...) {
        self.init(frame: frame)
        //setColors(colors)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaults()
    }
    
    var innerShadowOffset: CGSize! {
        get {
            
            return self.innerShadowOffset
        }
        
        set {
            //println("")
            self.setNeedsDisplay()
            }
    }
    
    override func drawRect(rect: CGRect) {
        //get drawing context
        if overSampling > minSamples || self.backgroundColor != nil  && self.backgroundColor != UIColor.clearColor()
        {
            var scalf = CGFloat(overSampling) as CGFloat
            //UIGraphicsBeginImageContextWithOptions(rect.size, false, scalf)
        }
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        var context = UIGraphicsGetCurrentContext()
        
       
        var textRect = rect;
        var fontSize = self.font.pointSize;
        if (self.adjustsFontSizeToFitWidth && self.numberOfLines == 1)
        {
              textRect = textRectForBounds(rect, limitedToNumberOfLines:1)
            
        }
        else
        {
            textRect = textRectForBounds(rect, limitedToNumberOfLines: self.numberOfLines)

        }
        
        //set font
        var font = self.font.fontWithSize(self.font.pointSize)
        
        //set color
        var highlightedColor = self.textColor
        var textColor =  self.textColor;
        
        //set position
        switch (self.textAlignment)
        {
        case NSTextAlignment.Center:
            
                textRect.origin.x = rect.origin.x + (rect.size.width - textRect.size.width) / 2.0;
                break;
            
        case NSTextAlignment.Right:
            
                textRect.origin.x = textRect.origin.x + rect.size.width - textRect.size.width;
                break;
            
        default:
            
                textRect.origin.x = rect.origin.x;
                break;
            
        }
        switch (self.contentMode)
        {
        case UIViewContentMode.Top:
            break;
        case UIViewContentMode.TopLeft:
            break;
        case UIViewContentMode.TopRight:
            
            textRect.origin.y = rect.origin.y;
            break;
            
        case UIViewContentMode.Bottom:
            break;
        case UIViewContentMode.BottomLeft:
            break;
        case UIViewContentMode.BottomRight:
            
                textRect.origin.y = rect.origin.y + rect.size.height - textRect.size.height;
                break;
            
        default:
            
                textRect.origin.y = rect.origin.y + (rect.size.height - textRect.size.height) / 2.0
                break;
            
        }
        
       var hasShadow = self.shadowColor != nil && self.shadowColor != UIColor.clearColor() && (shadowBlur > 0 || self.shadowOffset != CGSizeZero)
        
        var hasInnerShadow = innerShadowColor != nil && self.innerShadowColor != UIColor.clearColor() && innerShadowOffset != CGSizeZero
        
        var hasGradient:Bool = false
        if(gradientColors != nil)
        {
            hasGradient = gradientColors.count > 1
        }
        
        var needsMask = hasInnerShadow || hasGradient;
        
        var alphaMask:CGImageRef!
        if (needsMask)
        {
            //draw mask
            CGContextSaveGState(context);
            let str:NSString = self.text!
            let baselineAdjust = 1.0
            let attrsDictionary =  [NSFontAttributeName:font, NSBaselineOffsetAttributeName:baselineAdjust] as [NSObject : AnyObject]
            str.drawInRect(textRect, withAttributes: attrsDictionary)
            CGContextRestoreGState(context);
            
            // Create an image mask from what we've drawn so far
            alphaMask = CGBitmapContextCreateImage(context);
            
            //clear the context
            CGContextClearRect(context, textRect);
        }
        
        if (hasShadow)
        {
            //set up shadow
            CGContextSaveGState(context);
            var textAlpha = CGColorGetAlpha(textColor.CGColor)
            CGContextSetShadowWithColor(context, self.shadowOffset, shadowBlur, self.shadowColor!.CGColor)
            if needsMask
            {
                self.shadowColor?.colorWithAlphaComponent(textAlpha)
            }
            else
            {
                textColor.setFill()
            }
            if needsMask
            {
                self.shadowColor?.colorWithAlphaComponent(textAlpha)
            }
            else
            {
                textColor.setFill()
            }
            let str:NSString = self.text!
            let baselineAdjust = 1.0
            let attrsDictionary =  [NSFontAttributeName:font, NSBaselineOffsetAttributeName:baselineAdjust] as [NSObject : AnyObject]
            str.drawInRect(textRect, withAttributes: attrsDictionary)
            CGContextRestoreGState(context);

            CGContextRestoreGState(context);
        }
        else if (!needsMask)
        {
            //just draw the text
            textColor.setFill()
            let str:NSString = self.text!
            let baselineAdjust = 1.0
            let attrsDictionary =  [NSFontAttributeName:font, NSBaselineOffsetAttributeName:baselineAdjust] as [NSObject : AnyObject]
            str.drawInRect(textRect, withAttributes: attrsDictionary)
        }
        
        if (needsMask)
        {
            //clip the context
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, rect.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextClipToMask(context, rect, alphaMask);
            
            if (hasInnerShadow)
            {
                //fill inner shadow
                innerShadowColor.setFill()
                CGContextFillRect(context, textRect);
                
                //clip to unshadowed part
                CGContextTranslateCTM(context, innerShadowOffset.width, -innerShadowOffset.height);
                CGContextClipToMask(context, rect, alphaMask)
            }
            
            if (hasGradient)
            {
                //create array of pre-blended CGColors
                //var colors = NSMutableArray.ar   [NSMutableArray arrayWithCapacity:[gradientColors count]];
                var colors = NSMutableArray(capacity: gradientColors.count)
             
                for obj : AnyObject in gradientColors {
                    if let color = obj as? UIColor {
                        colors.addObject(color.CGColor)
                    }
                }

                //draw gradient
                CGContextScaleCTM(context, 1.0, -1.0);
                CGContextTranslateCTM(context, 0, -rect.size.height);
               let colorcf: CFArrayRef  = colors as CFArrayRef
                
                let n = gradientColors.count
                
                var locations : UnsafeMutablePointer<CGFloat> = UnsafeMutablePointer<CGFloat>(calloc(n, sizeof(CGFloat)))
                for i in 0..<n {
                    (locations + i).memory = CGFloat(Float(i) / Float(gradientColors.count))
                }

                var gradient:CGGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colorcf, locations)
                var startPoint = CGPointMake(textRect.origin.x + gradientStartPoint.x * textRect.size.width,
                    textRect.origin.y + gradientStartPoint.y * textRect.size.height);
                var endPoint = CGPointMake(textRect.origin.x + gradientEndPoint.x * textRect.size.width,
                    textRect.origin.y + gradientEndPoint.y * textRect.size.height)
                let options = CGGradientDrawingOptions(kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation)
                CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, options)
                locations.dealloc(n * sizeof(CGFloat))
            }
            else
            {
                textColor.setFill()
                CGContextFillRect(context, textRect);
            }
            
            CGContextRestoreGState(context);
           
        }
        
        if (overSampling != nil)
        {
            //UIGraphicsPushContext(UIGraphicsGetCurrentContext());
            var image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext()
            image.drawInRect(rect)
        
        }

    
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
