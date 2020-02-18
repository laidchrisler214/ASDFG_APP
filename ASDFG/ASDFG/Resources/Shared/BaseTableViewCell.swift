//
//  BaseTableViewCell.swift
//  ASDFG
//
//  Created by GreatFeat on 13/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func saveToUserDefaults(item: Any ,key: String) {
        UserDefaults.standard.set(item, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getFromUserDefault(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    func setContentFontSize() -> CGFloat {
        if let fontSize = getFromUserDefault(key: UserDefaultKeys.contentFontSize) as? CGFloat {
            return fontSize
        }
        return 18.0
    }

    func setDescFontSize() -> CGFloat {
        if let fontSize = getFromUserDefault(key: UserDefaultKeys.descFontSize) as? CGFloat {
            return fontSize
        }
        return 16.0
    }

}
