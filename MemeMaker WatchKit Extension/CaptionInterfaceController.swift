//
//  CaptionInterfaceController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import WatchKit
import Foundation
import MemeMakerKit

class CaptionInterfaceController: WKInterfaceController {

    var memeId:Int!
    @IBOutlet var topButton:WKInterfaceButton!
    @IBOutlet var bottomButton:WKInterfaceButton!
    var topText:String = "Top"
    var bottomText:String = "Bottom"

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.memeId = context as! Int
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func editTopText() {
        editTheText(self.topButton, stringVar: &self.topText)
    }
    @IBAction func editBottomText() {
        editTheText(self.bottomButton, stringVar: &self.bottomText)
    }
    
    func editTheText(sender:WKInterfaceButton, inout stringVar:String) {
        //https://www.natashatherobot.com/watchkit-text-input-dictation-api/
        let sampleTexts = ["Sample text for simulator", "because mic doesn't work"]
        presentTextInputControllerWithSuggestions(sampleTexts, allowedInputMode: .AllowEmoji) { input in
            if input != nil && input!.count > 0 && input![0] is String {
                stringVar = (input![0] as! String)
            } else {
                stringVar = ""
            }
            sender.setTitle(stringVar)
        }
    }
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return [self.memeId, self.topText, self.bottomText];
    }
}
