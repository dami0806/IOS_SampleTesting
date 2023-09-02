//
//  ViewController.swift
//  ChatTest
//
//  Created by 박다미 on 2023/08/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let textField = UITextField()
       let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("🍎")
        // Do any additional setup after loading the view.
        // UITextField 설정
               textField.placeholder = "텍스트를 입력하세요"
               textField.delegate = self
               view.addSubview(textField)

               // UILabel 설정
               label.text = "입력된 텍스트: "
               view.addSubview(label)
        // SnapKit을 사용하여 레이아웃 설정
               textField.snp.makeConstraints { make in
                   make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                   make.leading.trailing.equalToSuperview().inset(20)
                   make.height.equalTo(40)
               }

               label.snp.makeConstraints { make in
                   make.top.equalTo(textField.snp.bottom).offset(20)
                   make.leading.trailing.equalToSuperview().inset(20)
               }
           }

    }

extension ViewController: UITextFieldDelegate{
    // UITextFieldDelegate 메서드
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // 입력된 텍스트를 가져와서 라벨에 표시
           label.text = "입력된 텍스트: \(textField.text ?? "")"
           return true
       }
}

