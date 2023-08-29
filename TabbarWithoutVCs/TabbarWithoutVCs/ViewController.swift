//
//  ViewController.swift
//  TabbarWithoutVCs
//
//  Created by 박다미 on 2023/08/29.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private lazy var textLabel : UILabel = {
        let text = UILabel()
        return text
    }()
    private lazy var textLabel1 : UILabel = {
        let text = UILabel()
        text.text = "HI"
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setText()
        setText1()
        // 탭바 컨트롤러 생성
        let tabBarController = UITabBarController()
        
        // 탭바 아이템 생성
        let tabItems = [
            createTabItem(title: "A"),
            createTabItem(title: "B"),
            createTabItem(title: "C"),
            createTabItem(title: "D")
        ]
        
        // 탭바 아이템을 탭바 컨트롤러에 설정
        tabBarController.viewControllers = tabItems
        
        // 탭바 컨트롤러를 현재 뷰 컨트롤러에 추가
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        // 탭바 아이템을 선택했을 때 동작 설정
        if let tabBarController = children.first as? UITabBarController {
            tabBarController.delegate = self
        }
    }
        private func createTabItem(title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        return viewController
    }
    //text
    private func setText(){
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    private func setText1(){
        view.addSubview(textLabel1)
        textLabel1.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(20)
        }
    }
}
extension ViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            // 선택한 탭바 아이템의 인덱스에 따라 텍스트 레이블 변경
            let texts = ["A", "B", "C", "D"]
            textLabel.text = texts[index]
        }
    }}
