//
//  ChapterFiveDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterFiveDBManager {
    private var database:Realm
    static let sharedInstance = ChapterFiveDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterFiveModel> {
        let results: Results<ChapterFiveModel> = database.objects(ChapterFiveModel.self)
        return results
    }

    func addData(object: ChapterFiveModel) {
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
