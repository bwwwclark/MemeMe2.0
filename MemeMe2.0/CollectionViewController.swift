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
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme] {
        //get the memes from the app delegate
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set collection view as delegate and data source
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        //set flow layout dimensions
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //refresh data each time collection view is loaded
        myCollectionView.reloadData()
        
    }
    //count memes to return correct number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //dequeue cells and load memes into them
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        
        let meme = memes[indexPath.item]
        
        cell.topTextLabel!.text = meme.topTextField
        cell.bottomTextLabel!.text = meme.bottomTextField
        cell.imageView!.image = meme.memedImage
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        //select meme and send to detail view controller
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailController.meme = memes[indexPath.item]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
}




