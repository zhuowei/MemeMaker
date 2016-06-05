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
    static func sizeForAttributedText(attributedString:NSAttributedString, boundingSize:CGSize) -> CGSize {
        return attributedString.boundingRectWithSize(boundingSize, options: .UsesLineFragmentOrigin, context: nil).size
    }

    public static func memeImageForMeme(meme: MemeList, topText: String, bottomText: String) -> UIImage {
        let filePath = NSBundle(forClass: self).pathForResource(meme.id, ofType: "jpg", inDirectory: "meme_images")!
        let image = UIImage(contentsOfFile: filePath)!
        let size = image.size
        let vertMargin:CGFloat = 0
        UIGraphicsBeginImageContext(size)//image.size)
        image.drawAtPoint(CGPointZero)
        //http://stackoverflow.com/questions/31344787/uilabel-text-multi-line-given-width-of-text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping
        paragraphStyle.alignment = .Center
        let textAttrs:[String:AnyObject] = [NSFontAttributeName: UIFont(name: "Impact", size: 46)!,
                                            NSStrokeColorAttributeName: UIColor.blackColor(),
                                            NSStrokeWidthAttributeName: -4,
                                            NSForegroundColorAttributeName: UIColor.whiteColor(),
                                            NSParagraphStyleAttributeName: paragraphStyle];
        let topAtt = NSAttributedString(string: topText, attributes: textAttrs)
        let bottomAtt = NSAttributedString(string: bottomText, attributes: textAttrs)
        topAtt.drawInRect(CGRectMake(0, vertMargin, size.width, size.height))
        let bottomTextSize = sizeForAttributedText(bottomAtt, boundingSize: size)
        bottomAtt.drawInRect(CGRectMake(0, size.height - vertMargin - bottomTextSize.height,
            size.width, size.height))
        let retval = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retval
    }
}