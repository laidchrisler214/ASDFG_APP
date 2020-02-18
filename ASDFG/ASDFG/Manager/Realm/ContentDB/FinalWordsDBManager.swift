//
//  FinalWordsDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class FinalWordsDBManager {
    private var database:Realm
    static let sharedInstance = FinalWordsDBManager()

    private init() {
        database = try! Realm()
    }

    func getData() -> Results<FinalWordsModel> {
        let results: Results<FinalWordsModel> = database.objects(FinalWordsModel.self)
        return results
    }

    func addData(object: FinalWordsModel) {
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
