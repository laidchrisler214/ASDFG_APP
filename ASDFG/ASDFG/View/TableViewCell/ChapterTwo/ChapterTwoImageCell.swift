//
//  ChapterTwoImageCell.swift
//  ASDFG
//
//  Created by GreatFeat on 05/03/2018.
//  Copyright © 2018 LaidApps. All rights reserved.
//

import UIKit

class ChapterTwoImageCell: BaseTableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(data: ChapterTwoModel) {
        photo.image = UIImage(data: data.image)
    }
}
