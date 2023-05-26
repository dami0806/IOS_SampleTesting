//
//  SecondTableViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class SecondTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
        cell.images.image = UIImage(named: "Image")
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        guard let cell = tableView.cellForRow(at: indexPath) as? SecondTableViewCell else {
////            return
////        }
////
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let tableNextViewController = storyboard.instantiateViewController(withIdentifier: "TableNextViewController") as! TableNextViewController
////
////        tableNextViewController.getImage = cell.images.image
////        tableNextViewController.getTitleLabel = cell.titleLabel.text!
////
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tableNextViewController = storyboard.instantiateViewController(withIdentifier: "TableNextViewController") as! TableNextViewController
//        navigationController?.pushViewController(tableNextViewController, animated: true)
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tableNextViewController = storyboard.instantiateViewController(withIdentifier: "TableNextViewController") as! TableNextViewController
        
        // 선택된 셀의 이미지와 인덱스 번호를 전달
        if let cell = tableView.cellForRow(at: indexPath) as? SecondTableViewCell {
            tableNextViewController.getImage = cell.images.image
            tableNextViewController.getTitleLabel = cell.titleLabel.text!
        }
        
        // 현재 뷰 컨트롤러가 UINavigationController에 포함되어 있는지 확인
        if let navigationController = navigationController {
            navigationController.pushViewController(tableNextViewController, animated: true)
        } else {
            // UINavigationController에 포함되지 않은 경우, 새로운 UINavigationController를 생성하여 추가
            let navigationController = UINavigationController(rootViewController: tableNextViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }

}
