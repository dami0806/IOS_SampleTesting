//
//  TestTableViewCell.swift
//  TableView&ScrollView
//
//  Created by 박다미 on 2023/04/17.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
