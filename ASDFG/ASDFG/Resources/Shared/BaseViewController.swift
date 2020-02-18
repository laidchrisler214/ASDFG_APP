//
//  BaseViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func showNoContentAlert() {
        let alert = UIAlertController(title: "No Content", message: "Please connect to wifi or turn on cellular data to download content. Once content has been downloaded, you can use the app even without internet connection.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func saveToUserDefaults(item: Any ,key: String) {
        UserDefaults.standard.set(item, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getFromUserDefault(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    func removeFromUserDefaults(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }

    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }

    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }

    func increaseFont() {
        var contentFontSize = CGFloat(18.0)
        var descFontSize = CGFloat(16.0)

        if let fontSizeA = getFromUserDefault(key: UserDefaultKeys.contentFontSize) as? CGFloat {
            contentFontSize = fontSizeA
        }
        if let fontSizeB = getFromUserDefault(key: UserDefaultKeys.descFontSize) as? CGFloat {
            descFontSize = fontSizeB
        }

        contentFontSize += 1
        descFontSize += 1

        if contentFontSize < 60 {
            saveToUserDefaults(item: contentFontSize, key: UserDefaultKeys.contentFontSize)
            saveToUserDefaults(item: descFontSize, key: UserDefaultKeys.descFontSize)
        }
    }

    func decreaseFont() {
        var contentFontSize = CGFloat(18.0)
        var descFontSize = CGFloat(16.0)

        if let fontSizeA = getFromUserDefault(key: UserDefaultKeys.contentFontSize) as? CGFloat {
            contentFontSize = fontSizeA
        }
        if let fontSizeB = getFromUserDefault(key: UserDefaultKeys.descFontSize) as? CGFloat {
            descFontSize = fontSizeB
        }

        contentFontSize -= 1
        descFontSize -= 1

        if contentFontSize > 18 {
            saveToUserDefaults(item: contentFontSize, key: UserDefaultKeys.contentFontSize)
            saveToUserDefaults(item: descFontSize, key: UserDefaultKeys.descFontSize)
        }
    }

    func shouldUpdateDatabaseObjects() {
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateIntroDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterOneDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterTwoDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterThreeDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterFourDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterFiveDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterSixDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateChapterSevenDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdateFinalWordsDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdatePointersOneDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdatePointersTwoDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdatePointersThreeDatabase)
        saveToUserDefaults(item: true, key: UserDefaultKeys.shouldUpdatePointersFourDatabase)
    }
}
