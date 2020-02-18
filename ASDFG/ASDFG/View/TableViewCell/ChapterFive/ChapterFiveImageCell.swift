//
//  ChapterFiveImageCell.swift
//  ASDFG
//
//  Created by GreatFeat on 07/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterFiveImageCell: BaseTableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(data: ChapterFiveModel) {
        contentImage.image = UIImage(data: data.image)
    }
}
