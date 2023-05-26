//
//  SecondViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

//import UIKit
//
//class SecondViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
//
//    var dataManager = DataManager()
//   var dataArray: [Data] = []
//
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        dataManager.makeData()
//        dataArray = dataManager.getData()
//        collectionView.reloadData()
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
//        cell.imageView.image = dataArray[indexPath.row].imageView
//        cell.titleLabel.text = dataArray[indexPath.row].titleLabel
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataArray.count
//    }
//
//}
//
//struct Data {
//    var imageView: UIImage?
//    var titleLabel: String?
//}
//
//class DataManager{
//
//
//    private var dataArray: [Data] = []
//
//    func makeData() {
//        dataArray = [
//            Data(imageView: UIImage(named: "Image"), titleLabel: "1"),
//            Data(imageView: UIImage(named: "Image"), titleLabel: "2"),
//            Data(imageView: UIImage(named: "Image"), titleLabel: "3"),
//            Data(imageView: UIImage(named: "Image"), titleLabel: "4"),
//            Data(imageView: UIImage(named: "Image"), titleLabel: "5")
//        ]
//    }
//
//    func getData() -> [Data] {
//        return dataArray
//    }
//
//}

import UIKit


class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
}

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var dataManager = DataManager()
    var dataArray: [[Data]] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.makeData()
        dataArray = dataManager.getData()
        collectionView.reloadData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.imageView.image = dataArray[indexPath.section][indexPath.item].imageView
        cell.titleLabel.text = dataArray[indexPath.section][indexPath.item].titleLabel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            headerView.titleLabel.text = "섹션 \(indexPath.section + 1)의 헤더"
            return headerView
        }
        return UICollectionReusableView()
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let collectionViewWidth = collectionView.bounds.width
//           let itemWidth = collectionViewWidth / 2
//           let itemHeight = collectionView.bounds.height
//           return CGSize(width: itemWidth, height: itemHeight)
//       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = view.frame.width / 3
           let height: CGFloat = 120
           return CGSize(width: width, height: height)
       }
  
}

struct Data {
    var imageView: UIImage?
    var titleLabel: String?
}

class DataManager {
    private var dataArray: [[Data]] = []
    
    func makeData() {
        dataArray = [
            [
                Data(imageView: UIImage(named: "Image"), titleLabel: "1"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "2"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "3"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "11"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "12"),
               
            ],
            [
                Data(imageView: UIImage(named: "Image"), titleLabel: "4"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "5"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "6"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "1"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "2"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "3")
            ],
            [
                Data(imageView: UIImage(named: "Image"), titleLabel: "7"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "8"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "9"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "1"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "2"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "3"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "1"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "2"),
                Data(imageView: UIImage(named: "Image"), titleLabel: "3")
            ]
        ]
    }
    
    func getData() -> [[Data]] {
        return dataArray
    }
}
