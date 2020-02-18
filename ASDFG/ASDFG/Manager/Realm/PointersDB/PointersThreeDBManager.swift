//
//  PointersThreeDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class PointersThreeDBManager {
    private var database:Realm
    static let sharedInstance = PointersThreeDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<PointersThreeModel> {
        let results: Results<PointersThreeModel> = database.objects(PointersThreeModel.self)
        return results
    }

    func addData(object: PointersThreeModel) {
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
