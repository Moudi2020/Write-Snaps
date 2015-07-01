//
//  PicViewController.swift
//  
//
//  Created by Abdullah Bakhach on 5/31/15.
//
//

import UIKit

class PicViewController: UIViewController,UITextFieldDelegate {
    
   // var settingsViewController: SettingsViewController!
   // var controller = SettingsViewController()
   // var picviewcontroller = PicViewController()
    
    var enabledDrawing:Bool = false
    var imageSize:CGRect = CGRectMake(0, 0, 0, 0);
    var location = CGPoint(x: 0, y: 0)
    var alertTest = UIAlertView()
    var image:UIImage?
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var txt_field: UITextField!
    @IBOutlet weak var templateImageViewer: UIImageView!
    
    //Drawing variables
    var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsViewController = segue.destinationViewController as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.brush = brushWidth
        settingsViewController.opacity = opacity
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_field.center = CGPointMake(160, 330)
        txt_field.delegate = self
        txt_field.becomeFirstResponder()
        imageViewer.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
    
   // imageViewer.image = image
      //  imageSize = imageViewer.frame
      // imageViewer.contentMode = .ScaleAspectFill
        
     //   templateImageViewer.contentMode = .ScaleAspectFill
        
      //  imageSize = imageViewer.frame
        //view.frame.size = imageViewer.frame.size
       // print(imageSize)
    }
    
   /* @IBAction func reset(sender: AnyObject) {
        imageViewer.image = nil
    }
    */
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func savePicture(sender: UIButton) {
        
        var image:UIImage! = imageViewer.image
        
        UIGraphicsBeginImageContext(image.size)
        
        imageViewer.image?.drawInRect(CGRect(x: 0, y: 0,
            width: image.size.width, height: image.size.height))
        
        let images = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        ///ncode
        UIGraphicsBeginImageContextWithOptions(imageViewer.bounds.size, view.opaque, UIScreen.mainScreen().scale)
         view.layer.renderInContext(UIGraphicsGetCurrentContext())
        
       var  img:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let activity = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)

    }
    
    @IBAction func txtFildEdidtingEnd(sender: AnyObject) {
        txt_field.textAlignment = .Center
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewConstroller.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnDrawing(sender: UIButton) {
        enabledDrawing = true
        txt_field.hidden = true
    }
    
    @IBAction func btnTexting(sender: UIButton) {
        enabledDrawing = false
        txt_field.hidden = false
        txt_field.becomeFirstResponder()
    }
    
    override  func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
      if (!enabledDrawing)
      {
        var touch : UITouch! = touches.first as! UITouch
        
        location = touch.locationInView(self.view)
        
               txt_field.setY(y: location.y)
        
        }
        else
      {
        swiped = false
        if let touch = touches.first as? UITouch {
            lastPoint = touch.locationInView(self.view)
        }
      }
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(!enabledDrawing)
        {
        var touch : UITouch! = touches.first as! UITouch
        
        location = touch.locationInView(self.view)

    
            txt_field.setY(y: location.y)
        }
        else
        {
            swiped = true
            if let touch = touches.first as? UITouch {
                let currentPoint = touch.locationInView(view)
                drawLineFrom(lastPoint, toPoint: currentPoint)
                
                // 7
                lastPoint = currentPoint
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(enabledDrawing)
        {
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
            
            // Merge tempImageView into mainImageView
            UIGraphicsBeginImageContext(image!.size)
            imageViewer.image?.drawInRect(CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
            templateImageViewer.image?.drawInRect(CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
            imageViewer.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            templateImageViewer.image = nil

    }
        
    }
        func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
            
            
            // 1
            UIGraphicsBeginImageContext(view.frame.size)
            let context = UIGraphicsGetCurrentContext()
            templateImageViewer.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            // 2
            CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
            CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
            
            // 3
            CGContextSetLineCap(context, kCGLineCapRound)
            CGContextSetLineWidth(context, brushWidth)
            CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
            CGContextSetBlendMode(context, kCGBlendModeNormal)
            
            // 4
            CGContextStrokePath(context)
            
            // 5
            templateImageViewer.image = UIGraphicsGetImageFromCurrentImageContext()
            templateImageViewer.alpha = opacity
            UIGraphicsEndImageContext()

        }
   

    
    
    }


extension PicViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
        
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
    }
}



