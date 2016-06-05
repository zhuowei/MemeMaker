//
//  CaptionViewController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-05.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import UIKit
import MemeMakerKitiOS

class CaptionViewController: UIViewController {
    var memeId = 0
    var meme:MemeList!
    @IBOutlet var topTextView:UITextView!
    @IBOutlet var bottomTextView:UITextView!
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var imageViewHeightConstraint:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.meme = MemeList.memes[memeId]
        // Do any additional setup after loading the view.
        let imgPath = NSBundle(forClass: MemeList.self).pathForResource(self.meme.id, ofType: "jpg", inDirectory: "meme_images")!
        self.imageView.image = UIImage(contentsOfFile: imgPath)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        imageViewHeightConstraint.constant = self.imageView.image!.size.height * (self.imageView.frame.size.width / self.imageView.image!.size.width);
        self.view.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MemeGenerateSegue") {
            let target = segue.destinationViewController as! ShareViewController
            target.memeId = memeId
            target.topString = topTextView.text ?? ""
            target.bottomString = bottomTextView.text ?? ""
        }
    }

}
