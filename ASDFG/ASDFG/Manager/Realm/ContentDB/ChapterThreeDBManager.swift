//
//  ChapterThreeDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterThreeDBManager {
    private var database:Realm
    static let sharedInstance = ChapterThreeDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterThreeModel> {
        let results: Results<ChapterThreeModel> = database.objects(ChapterThreeModel.self)
        return results
    }

    func addData(object: ChapterThreeModel) {
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
