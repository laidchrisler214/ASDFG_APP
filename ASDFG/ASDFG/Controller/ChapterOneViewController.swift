//
//  ChapterOneViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterOneViewController: BaseViewController {

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
            if ChapterOneDBManager.sharedInstance.getData().isEmpty {
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            getChapterOneContent()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "ChapterOneContentCell", bundle: nil), forCellReuseIdentifier: "ChapterOneContentCell")
        tableView.register(UINib(nibName: "ChapterOneImageCell", bundle: nil), forCellReuseIdentifier: "ChapterOneImageCell")
        tableView.register(UINib(nibName: "ChapterOneDescriptionCell", bundle: nil), forCellReuseIdentifier: "ChapterOneDescriptionCell")
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
    func getChapterOneContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateChapterOneDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }
        
        if shouldUpdate {
            let request = ContentRequestManager()
            LoadingView.retrievingProgress()
            request.getChapterOneContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateChapterOneDatabase)
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

extension ChapterOneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChapterOneDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !ChapterOneDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterOneContentCell") as? ChapterOneContentCell
            cell?.set(data: ChapterOneDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterOneImageCell") as? ChapterOneImageCell
            cell?.set(data: ChapterOneDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterOneDescriptionCell") as? ChapterOneDescriptionCell
            cell?.set(data: ChapterOneDBManager.sharedInstance.getData()[indexPath.section])
            return cell!
        }
        return UITableViewCell()
    }
}

extension ChapterOneViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
