//
//  FifGetViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class FifGetViewController: UIViewController, FifDelegate {
    @IBOutlet weak var textLabel: UILabel!
      var fifViewController: FifViewController?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          // Get the instance of FifViewController from the storyboard
          if let viewController1 = storyboard?.instantiateViewController(withIdentifier: "FifViewController") as? FifViewController {
              fifViewController = viewController1
              fifViewController?.delegate = self
          }
      }
      
    func sendText(_ text: String) {
        if let label = textLabel {
            label.text = text
        } else {
            print("Error: textLabel is nil")
        }
    }
  }
