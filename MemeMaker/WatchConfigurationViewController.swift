//
//  WatchConfigurationViewController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-05.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import UIKit
import Accounts

class WatchConfigurationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLinkTwitterTapped() {
        // ask for backgrounding
        let accountStore = ACAccountStore()
        let type = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(type, options: nil) { granted, error in
            let alert: UIAlertController
            if (granted) {
                let accounts = accountStore.accountsWithAccountType(type)
                let message = (accounts != nil && accounts.count > 0) ? "You can now create memes from your watch and share them to your Twitter account" : "To share from your watch, add a Twitter account in your Phone's settings"
                alert = UIAlertController(title: "Twitter access granted", message: message,
                    preferredStyle: .Alert)
            } else {
                alert = UIAlertController(title: "Twitter access failed", message: "Failed to get access to your Twitter account. Go to your Phone's settings to grant access.", preferredStyle: .Alert)
            }
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }
    }

}
