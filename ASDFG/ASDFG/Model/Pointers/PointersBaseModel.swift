//
//  PointersBaseModel.swift
//  ASDFG
//
//  Created by GreatFeat on 09/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit
import RealmSwift

fileprivate enum apiKeys: String {
    case pointer = "pointer"
}

class PointersBaseModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var pointer = ""
    func set(data: NSDictionary) {
        id = getRandomId()
        pointer = data[apiKeys.pointer.rawValue] as? String ?? ""
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    func getRandomId() -> Int {
        return Int(arc4random_uniform(1000))
    }
}
