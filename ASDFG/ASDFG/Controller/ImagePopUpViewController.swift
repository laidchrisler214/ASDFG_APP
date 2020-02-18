//
//  ImagePopUpViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 12/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ImagePopUpViewController: BaseViewController {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var contentImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroller.minimumZoomScale = 1.0
        self.scroller.maximumZoomScale = 6.0
        self.showAnimate()
        getUserDefaults()
        self.tabBarController?.tabBar.isHidden = true
    }

    func getUserDefaults() {
        if let imageFromDefaults = self.getFromUserDefault(key: UserDefaultKeys.imageKey) as? Data {
            contentImage.image = UIImage(data: imageFromDefaults)
        }
    }

    @IBAction func removeViewAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        removeFromUserDefaults(key: UserDefaultKeys.imageKey)
        self.removeAnimate()
    }
}

extension ImagePopUpViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentImage
    }
}
