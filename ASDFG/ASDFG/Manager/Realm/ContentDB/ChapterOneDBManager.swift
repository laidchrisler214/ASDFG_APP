//
//  ChapterOneDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterOneDBManager {
    private var database:Realm
    static let sharedInstance = ChapterOneDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterOneModel> {
        let results: Results<ChapterOneModel> = database.objects(ChapterOneModel.self)
        return results
    }

    func addData(object: ChapterOneModel) {
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
