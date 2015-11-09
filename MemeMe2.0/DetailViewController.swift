//
//  DetailViewController.swift
//  MemeMe2.0
//
//  Created by Benjamin Clark  on 10/31/15.
//  Copyright © 2015 Benjamin Clark . All rights reserved.
//

import Foundation
import UIKit


class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!

    @IBOutlet weak var bottomText: UITextField!
    
    var meme : Meme!
    
    override func viewWillAppear(animate: Bool){
        
        prepTextField(bottomText,defaultText: "BOTTOM")
        prepTextField(topText,defaultText: "TOP")
        topText.text = meme.topTextField
        bottomText.text = meme.bottomTextField
        imageView.image = meme.image
        
        
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

    @IBAction func editButton(sender: AnyObject) {
        //perform segue with identifier and pass the text and image to meme editor view
    }
    
}