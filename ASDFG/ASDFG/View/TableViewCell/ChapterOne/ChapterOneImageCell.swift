//
//  ChapterOneImageCell.swift
//  ASDFG
//
//  Created by GreatFeat on 05/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterOneImageCell: BaseTableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(data: ChapterOneModel) {
        contentImage.image = UIImage(data: data.image)
    }
}
