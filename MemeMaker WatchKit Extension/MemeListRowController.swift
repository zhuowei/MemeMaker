//
//  MemeListRowController.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import WatchKit
import Foundation
import MemeMakerKit

class MemeListRowController: NSObject {
    @IBOutlet var nameLabel: WKInterfaceLabel!
    var meme: MemeList! {
        didSet {
            self.nameLabel.setText(meme.name)
        }
    }
}
