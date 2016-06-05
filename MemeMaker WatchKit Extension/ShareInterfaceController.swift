//
//  ShareInterfaceController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import WatchKit
import Foundation
import MemeMakerKit

class ShareInterfaceController: WKInterfaceController {
    @IBOutlet var shareButton:WKInterfaceButton!
    var memeImage:UIImage!

    override func awakeWithContext(context: AnyObject!) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let memeId = context[0] as! Int
        let topText = context[1] as! String
        let bottomText = context[2] as! String
        self.memeImage = GenerateMemeImage.memeImageForMeme(MemeList.memes[memeId], topText: topText, bottomText: bottomText)
        self.shareButton.setBackgroundImage(memeImage)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
