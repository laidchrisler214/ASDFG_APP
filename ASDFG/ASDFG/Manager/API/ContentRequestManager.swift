//
//  ContentRequestManager.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RealmSwift

class ContentRequestManager {

    var ref: DatabaseReference!

    func getIntroductionContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        IntroDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("introduction").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let introModel = IntroModel()
                introModel.set(data: data as! NSDictionary)
                IntroDBManager.sharedInstance.addData(object: introModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterOneContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterOneDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterOne").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapOneModel = ChapterOneModel()
                chapOneModel.set(data: data as! NSDictionary)
                ChapterOneDBManager.sharedInstance.addData(object: chapOneModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterTwoContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterTwoDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterTwo").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapTwoModel = ChapterTwoModel()
                chapTwoModel.set(data: data as! NSDictionary)
                ChapterTwoDBManager.sharedInstance.addData(object: chapTwoModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterThreeContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterThreeDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterThree").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapThreeModel = ChapterThreeModel()
                chapThreeModel.set(data: data as! NSDictionary)
                ChapterThreeDBManager.sharedInstance.addData(object: chapThreeModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterFourContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterFourDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterFour").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapFourModel = ChapterFourModel()
                chapFourModel.set(data: data as! NSDictionary)
                ChapterFourDBManager.sharedInstance.addData(object: chapFourModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterFiveContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterFiveDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterFive").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapFiveModel = ChapterFiveModel()
                chapFiveModel.set(data: data as! NSDictionary)
                ChapterFiveDBManager.sharedInstance.addData(object: chapFiveModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterSixContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterSixDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterSix").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapSixModel = ChapterSixModel()
                chapSixModel.set(data: data as! NSDictionary)
                ChapterSixDBManager.sharedInstance.addData(object: chapSixModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getChapterSevenContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        ChapterSevenDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("chapterSeven").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let chapSevenModel = ChapterSevenModel()
                chapSevenModel.set(data: data as! NSDictionary)
                ChapterSevenDBManager.sharedInstance.addData(object: chapSevenModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    func getFinalWordsContents( completionHandler: @escaping () -> Swift.Void, errorHandler: @escaping (Error) -> Swift.Void) -> Void {
        FinalWordsDBManager.sharedInstance.deleteAllData()
        ref = Database.database().reference()
        ref.child("finalWords").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapArray = snapshot.value! as? NSArray
            for data in snapArray! {
                let finalWordsModel = FinalWordsModel()
                finalWordsModel.set(data: data as! NSDictionary)
                FinalWordsDBManager.sharedInstance.addData(object: finalWordsModel)
            }
            completionHandler()
        }) { (error) in
            errorHandler(error)
        }
    }
}
