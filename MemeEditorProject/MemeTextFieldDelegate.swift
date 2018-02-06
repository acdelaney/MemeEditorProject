//
//  MemeTextFieldDelegate.swift
//  MemeEditorProject_Complete
//
//  Created by Andrew Delaney on 5/29/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    //setting attributes for formatting text fields
    
    let memeTextAttributes:[String:Any] = [
        
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]

    
    //Clearing textfields on editing
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "TOP" {
            textField.text = ""
        } else if textField.text == "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    //resign keyboard on return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       
        return true;
    }
    
    
    
}
