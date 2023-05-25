//
//  PagingKitViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/25.
//

import UIKit
import PagingKit
class PagingKitViewController: UIViewController {
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    static var viewController: (UIColor) -> UIViewController = { (color) in
          let vc = UIViewController()
           vc.view.backgroundColor = color
           return vc
       }
       
       var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? PagingMenuViewController {
               menuViewController = vc
               menuViewController.dataSource = self
               menuViewController.delegate = self // <- set menu delegate


           } else if let vc = segue.destination as? PagingContentViewController {
               contentViewController = vc
               contentViewController.dataSource = self // <- set content data source
               contentViewController.delegate = self // <- set content delegate

           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
              menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    


}
extension PagingKitViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }
}
extension PagingKitViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}
extension PagingKitViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
}
extension PagingKitViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
