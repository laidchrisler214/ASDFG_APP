//
//  ChapterSixDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterSixDBManager {
    private var database:Realm
    static let sharedInstance = ChapterSixDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterSixModel> {
        let results: Results<ChapterSixModel> = database.objects(ChapterSixModel.self)
        return results
    }

    func addData(object: ChapterSixModel) {
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
