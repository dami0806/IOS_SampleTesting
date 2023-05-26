//
//  MyThirdViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class MyThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tableViewTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let secondTableViewController = storyboard.instantiateViewController(withIdentifier: "SecondTableViewController") as! SecondTableViewController
          
          secondTableViewController.modalPresentationStyle = .fullScreen
          present(secondTableViewController, animated: true, completion: nil)
      }
          
    @IBAction func collectionViewTapped(_ sender: UIButton) {
        
 
        //네비쓸때
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
                let thirdVC = storyboard.instantiateViewController(withIdentifier: "MyThirdVC") as! MyThirdVC // Replace "MyThirdVC" with your view controller identifier

                // Push MyThirdVC onto the navigation stack
                navigationController?.pushViewController(thirdVC, animated: true)
                
            
    }
    
}
