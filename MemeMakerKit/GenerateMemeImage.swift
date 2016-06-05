//
//  GenerateMemeImage.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import Foundation
import UIKit

public class GenerateMemeImage {
    static func sizeForText(text: String, boundingSize:CGSize, attributes: [String: AnyObject]?) -> CGSize {
        //http://stackoverflow.com/questions/31344787/uilabel-text-multi-line-given-width-of-text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString.boundingRectWithSize(boundingSize, options: .UsesLineFragmentOrigin, context: nil).size
    }

    public static func memeImageForMeme(meme: MemeList, topText: String, bottomText: String) -> UIImage {
        let filePath = NSBundle(forClass: self).pathForResource(meme.id, ofType: "jpg", inDirectory: "meme_images")!
        let image = UIImage(contentsOfFile: filePath)!
        let size = image.size
        let vertMargin:CGFloat = 16
        UIGraphicsBeginImageContext(size)//image.size)
        image.drawAtPoint(CGPointZero)
        let topTextNS = topText as NSString, bottomTextNS = bottomText as NSString
        let textAttrs:[String:AnyObject] = [NSFontAttributeName: UIFont(name: "Impact", size: 72)!,
                                            NSStrokeColorAttributeName: UIColor.blackColor(),
                                            NSStrokeWidthAttributeName: -4,
                                            NSForegroundColorAttributeName: UIColor.whiteColor()];
        let topTextSize = sizeForText(topText, boundingSize: size, attributes: textAttrs)
        topTextNS.drawAtPoint(CGPointMake((size.width - topTextSize.width) / 2, vertMargin), withAttributes: textAttrs)
        let bottomTextSize = sizeForText(bottomText, boundingSize: size, attributes: textAttrs)
        bottomTextNS.drawAtPoint(CGPointMake((size.width - bottomTextSize.width) / 2, size.height - vertMargin - bottomTextSize.height), withAttributes: textAttrs)
        let retval = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retval
    }
}