//
//  SecondTableViewCell.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
