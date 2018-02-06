//
//  SentMemeTableVC.swift
//  MemeEditorProject
//
//  Created by Andrew Delaney on 6/25/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit

class SentMemeTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    // Initialize Meme array.
    
    var memes: [Meme]!{ return (UIApplication.shared.delegate as! AppDelegate).memes }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sent Memes"
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // To get the back button to show Sent Memes when it goes to the Meme Editor or Detail View
        
        let backItem = UIBarButtonItem()
        backItem.title = "Sent Memes"
        navigationItem.backBarButtonItem = backItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //Get the count for the table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
        
    }
    
    //Create the cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell2")! as! SentMemeTVCell
        let memes = self.memes[(indexPath as NSIndexPath).row]
        
        cell.sentMemeImage.image = memes.memedImage
        cell.sentMemeText.text = memes.topText + " " + memes.bottomText
        
        return cell
    }
    

     //Navigate to the Meme Detail upon selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailVC
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)       }

}
