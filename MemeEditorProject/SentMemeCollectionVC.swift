//
//  SentMemeCollectionVC.swift
//  MemeEditorProject
//
//  Created by Andrew Delaney on 6/26/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit

class SentMemeCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var memes: [Meme]!{ return (UIApplication.shared.delegate as! AppDelegate).memes }

    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var FlowLayout: UICollectionViewFlowLayout!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sent Memes"
        
    }
    
    override func viewWillLayoutSubviews() {
        let space:CGFloat = 1.0
        
        //Show three cells across for all orientations
        
        let width = (UIScreen.main.bounds.width - (2 * space)) / 3.0
        
        FlowLayout.minimumInteritemSpacing = space
        FlowLayout.minimumLineSpacing = space
        FlowLayout.itemSize = CGSize(width: width, height: width)

    }
    
    // Have Back button show Sent Memes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Sent Memes"
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CollectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    //Get number of cells from data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
   
    // Create cells for collection view
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollection", for: indexPath) as! SentMemeCollectionViewCell
        let memes = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.MemeImage?.image = memes.memedImage
        cell.contentMode = UIViewContentMode.scaleAspectFill
    
        return cell
    }
    
    // Navigate to Detail View when cell is selected
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailVC
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
}
