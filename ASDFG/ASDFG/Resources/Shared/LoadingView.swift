//
//  LoadingView.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit
import PKHUD

class LoadingView: NSObject {

    override init() {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }

    class func hide() {
        HUD.hide()
    }

    class func retrievingProgress() {
        DispatchQueue.main.async {
            HUD.show(.labeledRotatingImage(image: #imageLiteral(resourceName: "donut"), title: "Updating Content", subtitle: nil))
        }
    }

    class func nativeProgress() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }

    class func success(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            HUD.flash(.success, delay: 0.5) { (isFinish) in
                if isFinish {
                    completion()
                }
            }
        }
    }

    class func error(completion: @escaping () -> Void) {
        HUD.flash(.error, delay: 0.5) { (isFinish) in
            if isFinish {
                completion()
            }
        }
    }

    func error(message: String) {

    }

    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline:
            DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

