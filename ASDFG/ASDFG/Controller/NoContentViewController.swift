//
//  NoContentViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 07/06/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

protocol NoContentDelegate {
    func didClickRetry()
}

class NoContentViewController: BaseViewController {

    var delegate: NoContentDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
    }

    @IBAction func retryAction(_ sender: Any) {
        self.delegate?.didClickRetry()
        self.removeAnimate()
    }

}
