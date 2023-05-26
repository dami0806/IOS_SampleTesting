//
//  TableNextViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class TableNextViewController: UIViewController {
    var getImage: UIImage?
    var getTitleLabel:String = ""
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        images.image = getImage
        titleLabel.text = getTitleLabel
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
