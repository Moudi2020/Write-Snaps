//
//  ViewController.swift
//  Snap Write
//
//  Created by Abdullah Bakhach on 5/31/15.
//  Copyright (c) 2015 mhdtouban. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var picker  = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       picker.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btn_camera(sender: UIButton) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        self .presentViewController(picker, animated: true, completion: nil)
        }

    }
 
    
    @IBAction func btn_Gallery(sender: UIButton) {
        
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        print("inside picker")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       dismissViewControllerAnimated(true, completion: nil)
        
        // initialize the second view which will display the image
        let secondMainViewer = self.storyboard?.instantiateViewControllerWithIdentifier("PicViewController") as! PicViewController
        
        //display the image
       secondMainViewer.image = chosenImage
        
        //go to second view
        self.navigationController?.pushViewController(secondMainViewer, animated: true)
        
        
        // secondMainViewer.settingImageViewer(chosenImage)
     
    }
    
}
  

