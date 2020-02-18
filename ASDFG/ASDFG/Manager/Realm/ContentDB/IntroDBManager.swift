//
//  IntroDBManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import RealmSwift

class IntroDBManager {
    private var database:Realm
    static let sharedInstance = IntroDBManager()

    private init() {
        database = try! Realm()
        //just to identify the path
        print("path : \(database.configuration)")
    }

    func getData() -> Results<IntroModel> {
        let results: Results<IntroModel> = database.objects(IntroModel.self)
        return results
    }

    func addData(object: IntroModel) {
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
