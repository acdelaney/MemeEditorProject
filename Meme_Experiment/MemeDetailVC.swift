//
//  MemeDetailVC.swift
//  MemeEditorProject
//
//  Created by Andrew Delaney on 6/26/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

    //Initialize the meme
    
    var meme : Meme!
    
    
    @IBOutlet weak var ImageView: UIImageView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ImageView.image = meme.memedImage
        ImageView.contentMode = .scaleAspectFit
        self.tabBarController?.tabBar.isHidden = true
    }

}
