//
//  FifViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

protocol FifDelegate{
    func sendText(_ text: String)
}
class FifViewController: UIViewController {
   
        @IBOutlet weak var placeholderLabel: UILabel!
  var delegate: FifDelegate?
    
    @IBOutlet weak var textView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 텍스트 필드에 대한 델리게이트 설정
                textView.delegate = self
                // 플레이스홀더 레이블 초기화
                placeholderLabel.text = "문자를 입력하세요"
                placeholderLabel.isHidden = true
        
    }
    

    @IBAction func moveButtonTapped(_ sender: UIButton) {
           guard let text = textView.text, !text.isEmpty else {
               // Show alert or handle empty text case
               return
           }
           
           // Create an instance of FifGetViewController from the storyboard
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           guard let fifGetViewController = storyboard.instantiateViewController(withIdentifier: "FifGetViewController") as? FifGetViewController else {
               return
           }
           
           delegate = fifGetViewController
           delegate?.sendText(text)
           
           present(fifGetViewController, animated: true, completion: nil)
       }

        
    }
   



extension FifViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeholderLabel.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            placeholderLabel.isHidden = false
        }
    }
}
