//
//  PointersTwoDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class PointersTwoDBManager {
    private var database:Realm
    static let sharedInstance = PointersTwoDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<PointersTwoModel> {
        let results: Results<PointersTwoModel> = database.objects(PointersTwoModel.self)
        return results
    }

    func addData(object: PointersTwoModel) {
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
