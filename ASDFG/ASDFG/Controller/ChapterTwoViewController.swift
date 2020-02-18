//
//  ChapterTwoViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 05/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterTwoViewController: BaseViewController {

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
            if ChapterTwoDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getChapterTwoContent()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterTwoContentCell", bundle: nil), forCellReuseIdentifier: "ChapterTwoContentCell")
        tableView.register(UINib(nibName: "ChapterTwoImageCell", bundle: nil), forCellReuseIdentifier: "ChapterTwoImageCell")
        tableView.register(UINib(nibName: "ChapterTwoDescriptionCell", bundle: nil), forCellReuseIdentifier: "ChapterTwoDescriptionCell")
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
        saveToUserDefaults(item: ChapterTwoDBManager.sharedInstance.getData()[sender.tag].image, key: UserDefaultKeys.imageKey)
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
    func getChapterTwoContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateChapterTwoDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }

        if shouldUpdate {
            let request = ContentRequestManager()
            LoadingView.retrievingProgress()
            request.getChapterTwoContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateChapterTwoDatabase)
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
    @IBAction func increaseFontAction(_ sender: Any) {
        increaseFont()
        tableView.reloadData()
    }

    @IBAction func decreaseFontAction(_ sender: Any) {
        decreaseFont()
        tableView.reloadData()
    }
}

extension ChapterTwoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChapterTwoDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !ChapterTwoDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTwoContentCell") as? ChapterTwoContentCell
            cell?.set(data: ChapterTwoDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTwoImageCell") as? ChapterTwoImageCell
            cell?.set(data: ChapterTwoDBManager.sharedInstance.getData()[indexPath.section])
            cell?.imageButton.tag = indexPath.section
            cell?.imageButton.addTarget(self, action: #selector(showPopUpImage), for: .touchUpInside)
            return cell!
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTwoDescriptionCell") as? ChapterTwoDescriptionCell
            cell?.set(data: ChapterTwoDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        }
        return UITableViewCell()
    }
}

extension ChapterTwoViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
