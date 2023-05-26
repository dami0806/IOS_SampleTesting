//
//  MyThirdVC.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class MyThirdVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
      @IBOutlet weak var segmentControl: UISegmentedControl!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // segmentControl의 값 변경 이벤트를 감지하여 numberOfColumns를 업데이트
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        
    }
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        print(segmentControl.selectedSegmentIndex)
    }
      
   

}
