//
//  ChapterTwoContentCell.swift
//  ASDFG
//
//  Created by GreatFeat on 05/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterTwoContentCell: BaseTableViewCell {

    @IBOutlet weak var content: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(data: ChapterTwoModel) {
        let fontsize = setContentFontSize()
        let font = UIFont.systemFont(ofSize: fontsize)
        let attribute = [NSAttributedStringKey.font : font]
        let textAttributed = NSMutableAttributedString(string: data.paragraph, attributes: attribute)
        content.attributedText = textAttributed
    }
}
