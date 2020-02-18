//
//  BaseChapterModel.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit
import RealmSwift

fileprivate enum apiKeys: String {
    case image = "image"
    case imageDesc = "imageDesc"
    case paragraph = "paragraph"
}

class BaseChapterModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var image: Data!
    @objc dynamic var imageDesc = ""
    @objc dynamic var paragraph = ""

    func set(data: NSDictionary) {
        id = getRandomId()
        imageDesc = data[apiKeys.imageDesc.rawValue] as? String ?? ""
        paragraph = data[apiKeys.paragraph.rawValue] as? String ?? ""

        let urlString = data[apiKeys.image.rawValue] as? String ?? ""
        if let url = URL(string: urlString) {
            let imageData = downloadImage(url: url)
            image = imageData
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    func getRandomId() -> Int {
        return Int(arc4random_uniform(1000))
    }

    func downloadImage(url: URL) -> Data {
        var data = Data()
        if let imgData = NSData(contentsOf: url) as Data? {
            data = imgData
        }
        return data
    }
}
