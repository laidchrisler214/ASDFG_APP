//
//  ChapterFiveViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 07/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterFiveViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuOutlet: UIBarButtonItem!

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
            if ChapterFiveDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getPointers()
            getChapterFiveContent()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterFiveContentCell", bundle: nil), forCellReuseIdentifier: "ChapterFiveContentCell")
        tableView.register(UINib(nibName: "ChapterFiveImageCell", bundle: nil), forCellReuseIdentifier: "ChapterFiveImageCell")
        tableView.register(UINib(nibName: "ChapterFiveDescCell", bundle: nil), forCellReuseIdentifier: "ChapterFiveDescCell")
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

    @objc func showPopUpImage(sender: UIButton) -> Void  {
        let popOverVC: ImagePopUpViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePopUpViewController") as? ImagePopUpViewController)!
        saveToUserDefaults(item: ChapterFiveDBManager.sharedInstance.getData()[sender.tag].image, key: UserDefaultKeys.imageKey)
        self.addChildViewController(popOverVC)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
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
    func getChapterFiveContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateChapterFiveDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }
        
        if shouldUpdate {
            let request = ContentRequestManager()
            LoadingView.retrievingProgress()
            request.getChapterFiveContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateChapterFiveDatabase)
                self.tableView.reloadData()
            }, errorHandler: { (error) in
                LoadingView.hide()
                self.showAlert(error: error.localizedDescription)
            })
        } else {
            LoadingView.hide()
            self.tableView.reloadData()
        }
    }

    func getPointers() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdatePointersTwoDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }

        if shouldUpdate {
            let request = PointersRequestManager()
            request.getPointersTwoContents(completionHandler: {
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdatePointersTwoDatabase)
            }) { (error) in
                self.showAlert(error: error.localizedDescription)
            }
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

extension ChapterFiveViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChapterFiveDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !ChapterFiveDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
            return 3
        }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFiveContentCell") as? ChapterFiveContentCell
            cell?.set(data: ChapterFiveDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFiveImageCell") as? ChapterFiveImageCell
            cell?.set(data: ChapterFiveDBManager.sharedInstance.getData()[indexPath.section])
            cell?.imageButton.tag = indexPath.section
            cell?.imageButton.addTarget(self, action: #selector(showPopUpImage), for: .touchUpInside)
            return cell!
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFiveDescCell") as? ChapterFiveDescCell
            cell?.set(data: ChapterFiveDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        }
        return UITableViewCell()
    }
}

extension ChapterFiveViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
