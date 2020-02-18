//
//  DatabaseVersionCheckManager.swift
//  ASDFG
//
//  Created by GreatFeat on 21/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseVersionCheckManager {
    var ref: DatabaseReference!

    func getDatabaseVersion( completionHandler: @escaping (_ version: Int) -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ref = Database.database().reference()
        ref.child("databaseInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let version = value?["version"] as? Int ?? 0
            completionHandler(version)
        }) { (error) in
            errorHandler(error)
        }
    }
}
