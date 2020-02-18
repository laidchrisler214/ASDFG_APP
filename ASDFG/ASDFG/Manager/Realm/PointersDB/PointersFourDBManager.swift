//
//  PointersFourDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class PointersFourDBManager {
    private var database:Realm
    static let sharedInstance = PointersFourDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<PointersFourModel> {
        let results: Results<PointersFourModel> = database.objects(PointersFourModel.self)
        return results
    }

    func addData(object: PointersFourModel) {
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
