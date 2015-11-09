//
//  CollectionViewController.swift
//  MemeMe2.0
//
//  Created by Benjamin Clark  on 10/31/15.
//  Copyright © 2015 Benjamin Clark . All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController{

    
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let space: CGFloat = 3.0
//        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
//        
//        flowLayout.minimumInteritemSpacing = space
//        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
    
        let meme = memes[indexPath.item]
        cell.topTextLabel.text = meme.topTextField
          cell.bottomTextLabel.text = meme.bottomTextField
        cell.imageView.image = meme.memedImage
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
            
            //Grab the DetailVC from Storyboard
            let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")
            let detailVC = object as! DetailViewController
            
            //Populate view controller with data from the selected item
            detailVC.meme = self.memes[indexPath.item]
            
            //Present the view controller using navigation
            self.navigationController!.pushViewController(detailVC, animated: true)
    }
}




