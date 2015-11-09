//
//  TableViewController.swift
//  MemeMe2.0
//
//  Created by Benjamin Clark  on 10/31/15.
//  Copyright © 2015 Benjamin Clark . All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var memes: [Meme] {
        
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
    }
 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath) as! UITableViewCell!
        let meme = memes[indexPath.item]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topTextField
        
        return cell
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.meme = memes[indexPath.item]
        navigationController!.pushViewController(detailController, animated: true)
        
    }


    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            let memeDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            memeDelegate.memes.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }

}


