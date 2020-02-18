//
//  PointersThreeViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 12/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class PointersThreeViewController: BaseViewController {

    @IBOutlet weak var menuOutlet: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableEstimatedRowHeight()
        setSlideMenu()
        setNibs()
        getContent()
    }

    //MARK: - HELPER
    func getContent() {
        if !Reachability.isConnectedToNetwork() {
            if PointersThreeDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getPointers()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterSixPointersCell", bundle: nil), forCellReuseIdentifier: "ChapterSixPointersCell")
    }

    func setTableEstimatedRowHeight() {
        tableView.estimatedRowHeight = 45.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func setSlideMenu() {
        if self.revealViewController() != nil {
            menuOutlet.target = self.revealViewController()
            menuOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 0.80
        }
    }

    func showNoContentView() {
        if let popOverVC:NoContentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoContentViewController") as? NoContentViewController {
            popOverVC.delegate = self
            self.addChildViewController(popOverVC)
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
        }
    }

    //MARK: - API
    func getPointers() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdatePointersThreeDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }

        if shouldUpdate {
            let request = PointersRequestManager()
            LoadingView.retrievingProgress()
            request.getPointersThreeContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdatePointersThreeDatabase)
                self.tableView.reloadData()
            }) { (error) in
                LoadingView.hide()
                self.showAlert(error: error.localizedDescription)
            }
        } else {
            LoadingView.hide()
            self.tableView.reloadData()
        }
    }

    //MARK: - BUTTON ACTIONS
    @IBAction func increaseAction(_ sender: Any) {
        increaseFont()
        tableView.reloadData()
    }

    @IBAction func decreaseAction(_ sender: Any) {
        decreaseFont()
        tableView.reloadData()
    }
}

extension PointersThreeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PointersThreeDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterSixPointersCell") as? ChapterSixPointersCell
        cell?.set(data: PointersThreeDBManager.sharedInstance.getData()[indexPath.row])
        return cell!
    }
}

extension PointersThreeViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
