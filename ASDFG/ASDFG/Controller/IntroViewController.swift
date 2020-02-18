//
//  IntroViewController.swift
//  ASDFG
//
//  Created by GreatFeat on 26/02/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {

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
            if IntroDBManager.sharedInstance.getData().isEmpty {
                self.shouldUpdateDatabaseObjects()
                self.showNoContentView()
            }
            tableView.reloadData()
        } else {
            checkDatabaseVersion()
        }
    }

    func setNibs() {
        tableView.register(UINib(nibName: "IntroHeaderCell", bundle: nil), forCellReuseIdentifier: "IntroHeaderCell")
        tableView.register(UINib(nibName: "TableContentCell", bundle: nil), forCellReuseIdentifier: "TableContentCell")
        tableView.register(UINib(nibName: "TableImageCell", bundle: nil), forCellReuseIdentifier: "TableImageCell")
        tableView.register(UINib(nibName: "ImageDescriptionCell", bundle: nil), forCellReuseIdentifier: "ImageDescriptionCell")
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
    func checkDatabaseVersion() {
        var currentVersion = Int()
        if let databaseVersion = getFromUserDefault(key: UserDefaultKeys.databaseVersion) as? Int {
            currentVersion = databaseVersion
        } else {
            currentVersion = 0
        }
        LoadingView.retrievingProgress()
        let request = DatabaseVersionCheckManager()
        request.getDatabaseVersion(completionHandler: { (version) in
            if currentVersion != version {
                self.saveToUserDefaults(item: version, key: UserDefaultKeys.databaseVersion)
                self.shouldUpdateDatabaseObjects()
            } 

            self.getIntroContent()

        }) { (error) in
            LoadingView.hide()
            self.showAlert(error: error.localizedDescription)
        }
    }

    func getIntroContent() {
        var shouldUpdate = Bool()
        if let mustUpdate = getFromUserDefault(key: UserDefaultKeys.shouldUpdateIntroDatabase) as? Bool {
            shouldUpdate = mustUpdate
        }

        if shouldUpdate {
            let request = ContentRequestManager()
            request.getIntroductionContents(completionHandler: {
                LoadingView.hide()
                self.saveToUserDefaults(item: false, key: UserDefaultKeys.shouldUpdateIntroDatabase)
                self.tableView.reloadData()
            }, errorHandler: { (error) in
                LoadingView.hide()
                self.showAlert(error: error.localizedDescription)
            })
        } else {
            LoadingView.hide()
            tableView.reloadData()
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

extension IntroViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return IntroDBManager.sharedInstance.getData().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !IntroDBManager.sharedInstance.getData()[section].imageDesc.isEmpty {
            if section == 0 {
                return 4
            }
            return 3
        } else {
            if section == 0 {
                return 2
            }
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IntroHeaderCell") as? IntroHeaderCell
                return cell!
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableContentCell") as? TableContentCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableImageCell") as? TableImageCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDescriptionCell") as? ImageDescriptionCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            }
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableContentCell") as? TableContentCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableImageCell") as? TableImageCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDescriptionCell") as? ImageDescriptionCell
                cell?.set(data: IntroDBManager.sharedInstance.getData()[indexPath.section])
                return cell!
            }
        }

        return UITableViewCell()
    }
}

extension IntroViewController: NoContentDelegate {
    func didClickRetry() {
        self.getContent()
    }
}
