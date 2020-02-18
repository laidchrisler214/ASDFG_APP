//
//  ChapterFourViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 07/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterFourViewController: BaseViewController {

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
            if ChapterFourDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getPointers()
            getChapterFourContent()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterFourContentCell", bundle: nil), forCellReuseIdentifier: "ChapterFourContentCell")
        tableView.register(UINib(nibName: "ChapterFourImageCell", bundle: nil), forCellReuseIdentifier: "ChapterFourImageCell")
        tableView.register(UINib(nibName: "ChapterFourDescCell", bundle: nil), forCellReuseIdentifier: "ChapterFourDescCell")
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
        saveToUserDefaults(item: ChapterFourDBManager.sharedInstance.getData()[sender.tag].image, key: UserDefaultKeys.imageKey)
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
    func getChapterFourContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateChapterFourDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }
        
        if shouldUpdate {
            let request = ContentRequestManager()
            LoadingView.retrievingProgress()
            request.getChapterFourContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateChapterFourDatabase)
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
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdatePointersOneDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }

        if shouldUpdate {
            let request = PointersRequestManager()
            request.getPointersOneContents(completionHandler: {
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdatePointersOneDatabase)
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

extension ChapterFourViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChapterFourDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !ChapterFourDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFourContentCell") as? ChapterFourContentCell
            cell?.set(data: ChapterFourDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFourImageCell") as? ChapterFourImageCell
            cell?.set(data: ChapterFourDBManager.sharedInstance.getData()[indexPath.section])
            cell?.imageButton.tag = indexPath.section
            cell?.imageButton.addTarget(self, action: #selector(showPopUpImage), for: .touchUpInside)
            return cell!
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterFourDescCell") as? ChapterFourDescCell
            cell?.set(data: ChapterFourDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        }
        return UITableViewCell()
    }
}

extension ChapterFourViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
