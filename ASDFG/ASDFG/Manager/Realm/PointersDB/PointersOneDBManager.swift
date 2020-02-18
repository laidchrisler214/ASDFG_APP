//
//  PointersOneDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class PointersOneDBManager {
    private var database:Realm
    static let sharedInstance = PointersOneDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<PointersOneModel> {
        let results: Results<PointersOneModel> = database.objects(PointersOneModel.self)
        return results
    }

    func addData(object: PointersOneModel) {
        try! database.write {
            database.add(object, update: true)
        }
    }

    func deleteAllData()  {
        try! database.write {
            for object in getData() {
                database.delete(object)
            }
        }
    }
}
