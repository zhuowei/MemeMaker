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
        updateShareOptions()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateShareOptions() {
        self.facebookButton.setEnabled(false)
        self.twitterButton.setEnabled(false)
        self.configureSharingLabel.setText("Loading sharing options")
        let session = WCSession.defaultSession()
        session.delegate = self
        if (session.activationState != .Activated) {
            session.activateSession()
        }
        session.sendMessage(["r": "getSharingOptions"], replyHandler: { retval in
            self.facebookButton.setEnabled(retval["facebook"] as! Bool)
            self.twitterButton.setEnabled(retval["twitter"] as! Bool)
            self.configureSharingLabel.setText("Configure sharing options in the phone app")
        }, errorHandler: {err in
            print(err);
            self.configureSharingLabel.setText("Can't share: not connected to phone")
        })
    }

}
