//
//  ChapterTwoDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class ChapterTwoDBManager {
    private var database:Realm
    static let sharedInstance = ChapterTwoDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<ChapterTwoModel> {
        let results: Results<ChapterTwoModel> = database.objects(ChapterTwoModel.self)
        return results
    }

    func addData(object: ChapterTwoModel) {
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
