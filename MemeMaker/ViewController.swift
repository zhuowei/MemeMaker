//
//  ViewController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import UIKit
import MemeMakerKitiOS

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: dataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeList.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeListCell", forIndexPath: indexPath)
        let meme = MemeList.memes[indexPath.item]
        cell.textLabel!.text = meme.name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MemeChosenSegue") {
            (segue.destinationViewController as! CaptionViewController).memeId = (self.tableView.indexPathForSelectedRow?.item) ?? 0
        }
    }
}

