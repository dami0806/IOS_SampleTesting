//
//  ViewController.swift
//  TabbarWithBottomSheet
//
//  Created by 박다미 on 2023/09/05.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            let bottomSheet1 = BottomSheet1ViewController()
            let bottomSheet2 = BottomSheet2ViewController()
            let bottomSheet3 = BottomSheet3ViewController()
            
            bottomSheet1.tabBarItem = UITabBarItem(title: "Sheet 1", image: nil, tag: 0)
            bottomSheet2.tabBarItem = UITabBarItem(title: "Sheet 2", image: nil, tag: 1)
            bottomSheet3.tabBarItem = UITabBarItem(title: "Sheet 3", image: nil, tag: 2)
            
            viewControllers = [bottomSheet1, bottomSheet2, bottomSheet3]
        }
    }
