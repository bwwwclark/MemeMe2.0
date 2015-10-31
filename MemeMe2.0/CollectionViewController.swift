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
    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
//        let meme = memes[indexPath.item]
//        cell.setText(meme.top, bottomString: meme.bottom)
//        let imageView = UIImageView(image: meme.image)
//        cell.backgroundView = imageView
//        
//        return cell
//    }
//    
//    
//}




