//
//  ShareTargetsInterfaceController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-05.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UIKit

class ShareTargetsInterfaceController: WKInterfaceController, WCSessionDelegate {

    var memeImg:UIImage!
    @IBOutlet var facebookButton:WKInterfaceButton!
    @IBOutlet var twitterButton:WKInterfaceButton!
    @IBOutlet var configureSharingLabel:WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.memeImg = context as! UIImage
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func onShareToFacebook() {
        shareImage("facebook")
    }
    
    @IBAction func onShareToTwitter() {
        shareImage("twitter")
    }
    
    func shareImage(serviceName: String) {
        self.configureSharingLabel.setText("Sharing")
        let session = WCSession.defaultSession()
        session.delegate = self
        if (session.activationState != .Activated) {
            session.activateSession()
        }
        session.sendMessage(["r": "share", "s": serviceName, "i": UIImageJPEGRepresentation(self.memeImg, 0.9)!], replyHandler: { retval in
            let success = retval["success"] as! Bool
            if (!success) {
                self.configureSharingLabel.setText("Can't share to " + serviceName + ": go to the phone app and enable sharing")
            } else {
                self.configureSharingLabel.setText("Shared to " + serviceName)
            }
        }, errorHandler: {err in
            print(err);
            self.configureSharingLabel.setText("Can't share: not connected to phone")
        })
    }

}
