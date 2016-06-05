//
//  InterfaceController.swift
//  MemeMaker WatchKit Extension
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import WatchKit
import Foundation
import MemeMakerKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.table.setNumberOfRows(MemeList.memes.count, withRowType: "MemeListRow")
        for (i, meme) in MemeList.memes.enumerate() {
            let controller = self.table.rowControllerAtIndex(i) as! MemeListRowController
            controller.meme = meme
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return rowIndex
    }

}
