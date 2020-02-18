//
//  ImageDescriptionCell.swift
//  ASDFG
//
//  Created by GreatFeat on 01/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ImageDescriptionCell: BaseTableViewCell {

    @IBOutlet weak var contentDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(data: IntroModel) {
        let fontsize = setDescFontSize()
        let font = UIFont.systemFont(ofSize: fontsize)
        let attribute = [NSAttributedStringKey.font : font]
        let textAttributed = NSMutableAttributedString(string: data.imageDesc, attributes: attribute)
        contentDescription.attributedText = textAttributed
    }

}
