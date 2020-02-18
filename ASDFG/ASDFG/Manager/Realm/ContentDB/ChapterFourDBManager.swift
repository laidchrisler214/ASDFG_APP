//
//  ChapterFourDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterFourDBManager {
    private var database:Realm
    static let sharedInstance = ChapterFourDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterFourModel> {
        let results: Results<ChapterFourModel> = database.objects(ChapterFourModel.self)
        return results
    }

    func addData(object: ChapterFourModel) {
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
