//
//  ChapterThreeViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 06/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterThreeViewController: BaseViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
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
            if ChapterThreeDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getChapterThreeContent()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterThreeContentCell", bundle: nil), forCellReuseIdentifier: "ChapterThreeContentCell")
        tableView.register(UINib(nibName: "ChapterThreeImageCell", bundle: nil), forCellReuseIdentifier: "ChapterThreeImageCell")
        tableView.register(UINib(nibName: "ChapterThreeDescCell", bundle: nil), forCellReuseIdentifier: "ChapterThreeDescCell")
    }

    func setTableEstimatedRowHeight() {
        tableView.estimatedRowHeight = 45.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func setSlideMenu() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 0.80
        }
    }

    @objc func showPopUpImage(sender: UIButton) -> Void  {
        let popOverVC: ImagePopUpViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePopUpViewController") as? ImagePopUpViewController)!
        saveToUserDefaults(item: ChapterThreeDBManager.sharedInstance.getData()[sender.tag].image, key: UserDefaultKeys.imageKey)
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
    func getChapterThreeContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateChapterThreeDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }
        
        if shouldUpdate {
            let request = ContentRequestManager()
            LoadingView.retrievingProgress()
            request.getChapterThreeContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateChapterThreeDatabase)
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

extension ChapterThreeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChapterThreeDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !ChapterThreeDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterThreeContentCell") as? ChapterThreeContentCell
            cell?.set(data: ChapterThreeDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterThreeImageCell") as? ChapterThreeImageCell
            cell?.set(data: ChapterThreeDBManager.sharedInstance.getData()[indexPath.section])
            cell?.imageButton.tag = indexPath.section
            cell?.imageButton.addTarget(self, action: #selector(showPopUpImage), for: .touchUpInside)
            return cell!
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterThreeDescCell") as? ChapterThreeDescCell
            cell?.set(data: ChapterThreeDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        }
        return UITableViewCell()
    }
}

extension ChapterThreeViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
