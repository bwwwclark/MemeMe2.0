//
//  ViewController.swift
//  MemeMe2.0
//
//  Created by Benjamin Clark  on 10/31/15.
//  Copyright © 2015 Benjamin Clark . All rights reserved.
//

import UIKit


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var TopText: UITextField!
    
    @IBOutlet weak var BottomText: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var beginText: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var meme = Meme!()
    //var fromEditButton = Bool?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set default text
        
        
        prepTextField(BottomText,defaultText: "BOTTOM")
        prepTextField(TopText,defaultText: "TOP")
        shareButton.enabled = false
        
        //Set meme attributes from DetailViewController if they exist
        
        if meme == nil{
        }else {
            TopText.text = meme.topTextField
            BottomText.text = meme.bottomTextField
            imageView.image = meme.image
            beginText.text = ""
            shareButton.enabled = true
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func prepTextField(textField: UITextField, defaultText: String) {
        
        //set all text field attributes for the app
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -4.0
        ]
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.autocapitalizationType = .AllCharacters
        textField.textAlignment = .Center
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //hide camera if disabled
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //subscribe to keyboard notifications
        
        subscribeToKeyboardNotifications()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsubscribe to keyboard notifications
        
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        //defines keyboard notifications subscription
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        //defines keyboard notification for unsubscribe
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        //shift keyboard up for bottom text
        
        if BottomText.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        //shift keyboard down after finishing writing bottom text
        
        if BottomText.resignFirstResponder(){
            view.frame.origin.y = 0
        }
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        //get the keyboard height
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        //clears default text when editing begins
        
        if textField.text == "TOP"{
            textField.text = " "
        }
        if textField.text == "BOTTOM"{
            textField.text = " "
        }
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
        //make begin label go away
        beginText.text = ""
        
        //enable the share button
        shareButton.enabled = true
        
    }
    
    
    func memeImage() -> UIImage {
        //sets created meme as an image for sharing
        toolBar.hidden = true
        cancelButton.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        cancelButton.hidden = false
        
        
        return memedImage
    }
    
    
    func save(meme :Meme) {
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    @IBAction func photosButton(sender: AnyObject) {
        //launch photo picker
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButton(sender: AnyObject) {
        //take a picture to use in the meme
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        TopText.resignFirstResponder()
        BottomText.resignFirstResponder()
        
        //get the meme image to share
        let newMemedImage = memeImage()
        
        //set all the meme attributes to save
        
        let newmeme = Meme(
            topTextField: TopText.text,
            bottomTextField: BottomText.text,
            image: imageView.image,
            memedImage: newMemedImage
        )
        
        //launch acitivity view controller to share meme
        let avc = UIActivityViewController(activityItems: [newMemedImage], applicationActivities: nil)
        presentViewController(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = { activity, success, items, error in
            if success {
                
                //save meme when shared successfully
                self.save(newmeme)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}




