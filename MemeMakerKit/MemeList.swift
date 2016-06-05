//
//  MemeList.swift
//  MemeMaker
//
//  Created by Zhuowei Zhang on 2016-06-04.
//  Copyright © 2016 Zhuowei Zhang. All rights reserved.
//

import Foundation

public class MemeList {
    public static var memes:Array<MemeList> = MemeList.loadMemes()
    public let name, id:String
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    static func loadMemes() -> Array<MemeList> {
        let memesPath = NSBundle(forClass: self).pathForResource("memes", ofType: "json")
        let stream = NSInputStream(fileAtPath: memesPath!)!
        stream.open()
        let inputdata = try! NSJSONSerialization.JSONObjectWithStream(stream, options:[])
        let data = inputdata["data"] as! Array<Dictionary<String, AnyObject>>
        var outputlist = Array<MemeList>()
        for memeobj in data {
            outputlist.append(MemeList(name: memeobj["title"] as! String, id: memeobj["id"] as! String))
        }
        return outputlist
    }
}