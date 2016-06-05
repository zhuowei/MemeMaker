//
//  ShareViewController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-05.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import UIKit
import MemeMakerKitiOS

class ShareViewController: UIViewController {

    var memeId = 0
    var topString:String = ""
    var bottomString:String = ""
    var memeImg:UIImage!
    @IBOutlet var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memeImg = GenerateMemeImage.memeImageForMeme(MemeList.memes[memeId], topText: topString, bottomText: bottomString)
        self.imageView.image = memeImg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSharePressed(sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [self.memeImg], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
