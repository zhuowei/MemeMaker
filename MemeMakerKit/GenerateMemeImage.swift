//
//  GenerateMemeImage.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import Foundation
import UIKit

class GenerateMemeImage {
    static func memeImageForMeme(meme: MemeList, topText: String, bottomText: String) -> UIImage {
        let filePath = NSBundle(forClass: self).pathForResource(meme.id, ofType: "png", inDirectory: "meme_templates")!
        let image = UIImage(contentsOfFile: filePath)!
        UIGraphicsBeginImageContext(image.size)
        UIGraphicsEndImageContext()
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}