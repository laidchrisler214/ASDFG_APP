//
//  PointersRequestManager.swift
//  ASDFG
//
//  Created by GreatFeat on 09/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift

class PointersRequestManager {
    var ref: DatabaseReference!

    func getPointersOneContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        PointersOneDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("pointersOne").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let pointersModel = PointersOneModel()
                pointersModel.set(data: data as! NSDictionary)
                PointersOneDBManager.sharedInstance.addData(object: pointersModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getPointersTwoContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        PointersTwoDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("pointersTwo").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let pointersModel = PointersTwoModel()
                pointersModel.set(data: data as! NSDictionary)
                PointersTwoDBManager.sharedInstance.addData(object: pointersModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getPointersThreeContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        PointersThreeDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("pointersThree").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let pointersModel = PointersThreeModel()
                pointersModel.set(data: data as! NSDictionary)
                PointersThreeDBManager.sharedInstance.addData(object: pointersModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getPointersFourContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        PointersFourDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("pointersFour").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let pointersModel = PointersFourModel()
                pointersModel.set(data: data as! NSDictionary)
                PointersFourDBManager.sharedInstance.addData(object: pointersModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }
}
