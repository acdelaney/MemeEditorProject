//
//  ViewController.swift
//  MemeEditorProject_Complete
//
//  Created by Andrew Delaney on 5/21/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextbox: UITextField!
    @IBOutlet weak var bottomTextbox: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    //TextField delegate object
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
      
    //Hide the status bar to show navigation bar at very top
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields(textField: topTextbox, withText: "TOP")
        configureTextFields(textField: bottomTextbox, withText: "BOTTOM")
    }

    //Set textfield delegates and format text for both fields

    func configureTextFields(textField: UITextField, withText: String) {
        
        textField.delegate = memeTextFieldDelegate
        textField.defaultTextAttributes = memeTextFieldDelegate.memeTextAttributes
        textField.textAlignment = .center
        textField.text = withText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        subscribeToKeyboardNotifications()

        imagePickerView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    
        //Disable Share button until Meme has picture
        
        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    
    //Following functions relate to subscribing and unsubscribing to notifications for the keyboard
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //Following functions are used for showing and hiding the keyboard as well as moving the view up when the bottom textField is being edited
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextbox.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        
    }
    
    //This resets the view if the cancel button is pressed.

    @IBAction func cancelMeme(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Opens up the Camera view
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        chooseSourceType(sourceType: .camera)
      
    }

    //Opens the Image Picker View Controller
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        chooseSourceType(sourceType: .photoLibrary)
       
    }
    
    //Allows the user to pick a picture from the photo album
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //Used to open the camera or photo library
    
    func chooseSourceType(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //Opens the Activity View Controller to share the Meme on social media or text, etc
    
    @IBAction func shareMeme(_ sender: Any) {
        var memedImage: UIImage!
        memedImage = generateMemedImage()
        let shareMeme = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareMeme.completionWithItemsHandler = { (activity, completed, items, error) in
            if (completed) {
                self.save(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(shareMeme, animated: true, completion: nil)
    }
    
    //Takes a snapshot of the screen to be used as the Meme
    
    func generateMemedImage() -> UIImage {
        
       configureBars(configure: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
       configureBars(configure: false)
    
        return memedImage
    }
    
    //Hide and show tool bar and nav bar
    
    func configureBars(configure: Bool) {
        self.navBar.isHidden = configure
        self.toolBar.isHidden = configure
    }
    
    //Save's the image as a meme with the text
    
    func save(memedImage: UIImage){
        let meme = Meme(topText: topTextbox.text!, bottomText: bottomTextbox.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        // Return to the previous view
        
        dismiss(animated: true, completion: nil)
        //navigationController!.popViewController(animated: true)
    }
    
  
}

