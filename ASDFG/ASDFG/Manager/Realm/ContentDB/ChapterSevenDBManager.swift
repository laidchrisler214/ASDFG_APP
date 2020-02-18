//
//  ChapterSevenDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterSevenDBManager {
    private var database:Realm
    static let sharedInstance = ChapterSevenDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterSevenModel> {
        let results: Results<ChapterSevenModel> = database.objects(ChapterSevenModel.self)
        return results
    }

    func addData(object: ChapterSevenModel) {
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
