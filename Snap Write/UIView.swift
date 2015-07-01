//
//  UIView.swift
//  Snap Write
//
//  Created by Abdullah Bakhach on 6/1/15.
//  Copyright (c) 2015 mhdtouban. All rights reserved.
//


import UIKit

extension UIView {
    
    func pb_takeSnapshot(image:UIImageView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.frame.size, false, UIScreen.mainScreen().scale)
        
        drawViewHierarchyInRect(image.bounds, afterScreenUpdates: true)
        
        // old style: layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
    Extension UIView
    by DaRk-_-D0G
    */
        /**
        Set x Position
        
        :param: x CGFloat
        by DaRk-_-D0G
        */
        func setX(#x:CGFloat) {
            var frame:CGRect = self.frame
            frame.origin.x = x
            self.frame = frame
        }
        /**
        Set y Position
        
        :param: y CGFloat
        by DaRk-_-D0G
        */
        func setY(#y:CGFloat) {
            var frame:CGRect = self.frame
            frame.origin.y = y
            self.frame = frame
        }
        /**
        Set Width
        
        :param: width CGFloat
        by DaRk-_-D0G
        */
        func setWidth(#width:CGFloat) {
            var frame:CGRect = self.frame
            frame.size.width = width
            self.frame = frame
        }
        /**
        Set Height
        
        :param: height CGFloat
        by DaRk-_-D0G
        */
        func setHeight(#height:CGFloat) {
            var frame:CGRect = self.frame
            frame.size.height = height
            self.frame = frame
        }
}