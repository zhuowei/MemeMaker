//
//  AppDelegate.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import UIKit
import WatchConnectivity
import Accounts
import Social

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let method = (message["r"] as! String)
        if method == "share" {
            // ask for backgrounding
            let accountStore = ACAccountStore()
            let type:ACAccountType
            let typeName:String = message["s"] as! String
            if (typeName == "facebook") {
                type = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
            } else if (typeName == "twitter") {
                type = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            } else {
                assert(false, "invalid account type " + typeName)
                abort()
            }
            let accounts = accountStore.accountsWithAccountType(type)
            let theAccount:ACAccount! = (accounts != nil && accounts!.count > 0) ? accounts![0] as! ACAccount : nil
            if (theAccount == nil) {
                replyHandler(["success": false])
                return
            }
            postWithSocialAccount(theAccount, imageData: message["i"] as! NSData, imageType: "image/jpeg") { error in
                print("social post done with error ", error)
                replyHandler(["success": error == nil])
            }
        } else {
            assert(false, "invalid request method " + method)
        }
    }
    
    func postWithSocialAccount(account: ACAccount, imageData: NSData, imageType: String, completion: (NSError?) -> Void) {
        if (account.accountType.identifier == ACAccountTypeIdentifierFacebook) {
            // todo
            abort()
        } else if (account.accountType.identifier == ACAccountTypeIdentifierTwitter) {
            let uploadRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .POST,
                URL: NSURL(string: "https://upload.twitter.com/1.1/media/upload.json"), parameters: [:])
            uploadRequest.addMultipartData(imageData, withName: "media", type: imageType, filename: "memes.jpg")
            uploadRequest.account = account
            uploadRequest.performRequestWithHandler() { data, response, error in
                if (error != nil) {
                    completion(error);
                    return;
                }
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    let mediaId = json["media_id_string"] as? String
                    if (mediaId == nil) {
                        completion(NSError(domain: "net.zhuoweizhang.MemeMaker", code: 0x1000, userInfo: ["message": "media upload to twitter failed", "json": json]))
                        return
                    }
                    let updateRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .POST,
                        URL: NSURL(string: "https://api.twitter.com/1.1/statuses/update.json"),
                        parameters: ["status": "Shared via MemeMaker from my Watch", "media_ids": mediaId!])
                    updateRequest.account = account
                    updateRequest.performRequestWithHandler() { data, response, error in
                        completion(error);
                    }
                } catch let a as NSError {
                    completion(a)
                }
            }
        } else {
            abort()
        }
    }

}

