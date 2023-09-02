//
//  ViewController.swift
//  TabbarWithoutVCs
//
//  Created by 박다미 on 2023/08/29.
//

import UIKit
import SnapKit
import UIKit
//
//class ViewController: UIViewController {
//
//    private var viewA: UIView!
//    private var viewB: UIView!
//    private var viewC: UIView!
//    private var viewD: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        viewA = createColoredView(color: .red)
//        viewB = createColoredView(color: .blue)
//        viewC = createColoredView(color: .green)
//        viewD = createColoredView(color: .yellow)
//
//        // 초기에는 첫 번째 뷰만 보이도록 설정
//        view.addSubview(viewA)
//        view.addSubview(viewB)
//        view.addSubview(viewC)
//        view.addSubview(viewD)
//
//        // 뷰를 숨김
//        viewB.isHidden = true
//        viewC.isHidden = true
//        viewD.isHidden = true
//
//        // 버튼을 생성하고 액션 설정
//        let buttonA = createButton(title: "A")
//        let buttonB = createButton(title: "B")
//        let buttonC = createButton(title: "C")
//        let buttonD = createButton(title: "D")
//
//        buttonA.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        buttonB.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        buttonC.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        buttonD.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//
//        // 버튼을 화면에 추가
//        let stackView = UIStackView(arrangedSubviews: [buttonA, buttonB, buttonC, buttonD])
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        view.addSubview(stackView)
//
//        // 버튼 및 뷰의 제약 조건 설정
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.left.equalTo(20)
//            make.right.equalTo(-20)
//            make.height.equalTo(40)
//        }
//
//        // 뷰의 제약 조건 설정
//        viewA.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        viewB.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        viewC.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        viewD.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//
//    @objc func buttonTapped(_ sender: UIButton) {
//        // 버튼에 따라 해당하는 뷰만 보이도록 처리
//        viewA.isHidden = true
//        viewB.isHidden = true
//        viewC.isHidden = true
//        viewD.isHidden = true
//
//        switch sender.titleLabel?.text {
//        case "A":
//            viewA.isHidden = false
//        case "B":
//            viewB.isHidden = false
//        case "C":
//            viewC.isHidden = false
//        case "D":
//            viewD.isHidden = false
//        default:
//            break
//        }
//    }
//
//    private func createColoredView(color: UIColor) -> UIView {
//        let view = UIView()
//        view.backgroundColor = color
//        return view
//    }
//
//    private func createButton(title: String) -> UIButton {
//        let button = UIButton()
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        return button
//    }
//}
//
////
import UIKit
import SnapKit

class BViewController: UIViewController {
    private lazy var greenCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 25
        return view
    }()

    // ViewController로부터 textLabel1의 위치 정보를 전달받을 프로퍼티
    var textLabel1Frame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // "B" 탭바 아이템에 해당하는 뷰 컨트롤러의 배경색을 파란색으로 설정
        view.backgroundColor = .lightGray
        

        // textLabel1의 위치 정보를 사용하여 초록색 동그라미 위치 설정
              if let frame = textLabel1Frame {
                  view.addSubview(greenCircleView)
                  
                  greenCircleView.snp.makeConstraints { make in
                      make.leading.equalToSuperview().inset(frame.origin.x) // X 좌표 설정
                      make.top.equalToSuperview().inset(frame.origin.y) // Y 좌표 설정
                      make.width.height.equalTo(frame.size) // 너비와 높이 설정
                  }
              }
          }
    
}

final class ViewController: UIViewController {
    private lazy var textLabel: UILabel = {
        let text = UILabel()
        return text
    }()
    
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "HI"
        return text
    }()
    
    private var circleView: UIView?
    private var helloLabel: UILabel?
    
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
        
        // 'B' 탭바 아이템에 해당하는 뷰 컨트롤러 생성
        // BViewController를 생성하고 textLabel1의 위치 정보 전달
        let bViewController = BViewController()
        bViewController.textLabel1Frame = textLabel1.frame
        bViewController.tabBarItem = createTabItem(title: "B")
        
        // 탭바 아이템에 해당하는 뷰 컨트롤러 설정
        let viewControllers: [UIViewController] = [
            createViewController(title: "A"),
            bViewController, // "B" 탭바 아이템에 해당하는 뷰 컨트롤러 변경
            createViewController(title: "C"),
            createViewController(title: "D")
        ]
        
        // 탭바 아이템을 탭바 컨트롤러에 설정
        tabBarController.viewControllers = viewControllers
        
        // 탭바 컨트롤러를 현재 뷰 컨트롤러에 추가
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        // 탭바 아이템을 선택했을 때 동작 설정
        if let tabBarController = children.first as? UITabBarController {
            tabBarController.delegate = self
        }
    }
    
    private func createTabItem(title: String) -> UITabBarItem {
        return UITabBarItem(title: title, image: nil, selectedImage: nil)
    }
    
    // 'createViewController' 함수 정의
    private func createViewController(title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        return viewController
    }
    
    // text
    private func setText() {
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setText1() {
        view.addSubview(textLabel1)
        textLabel1.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(150)
        }
    }
    
    // A 탭을 선택했을 때 Hello 추가
    private func addHelloLabel() {
        if helloLabel == nil {
            helloLabel = UILabel()
            helloLabel!.text = "Hello"
            view.addSubview(helloLabel!)
            
            helloLabel!.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(textLabel1.snp.bottom).offset(20)
            }
        }
    }
    
    // C 탭을 선택했을 때 동그라미 위치 조정
    private func adjustCircleViewPosition() {
        if let circleView = circleView {
            circleView.snp.updateConstraints { make in
                make.leading.equalTo(textLabel1.snp.trailing).offset(20)
            }
        }
    }
}

extension ViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            // 선택한 탭바 아이템의 인덱스에 따라 텍스트 레이블 변경
            let texts = ["A", "B", "C", "D"]
            textLabel.text = texts[index]
            
            // B 탭을 선택한 경우 HI 위에 원을 그리고 다른 탭을 선택한 경우 원을 제거
            if index == 1 {
                createCircleView()
            } else {
                removeCircleView()
            }
            
            // A 탭을 선택한 경우 Hello 추가
            if index == 0 {
                addHelloLabel()
            } else {
                removeHelloLabel()
            }
            
            // C 탭을 선택한 경우 동그라미 위치 조정
            if index == 2 {
                adjustCircleViewPosition()
            }
        }
    }
    
    private func createCircleView() {
        if circleView == nil {
            circleView = UIView()
            circleView!.backgroundColor = .green
            circleView!.layer.cornerRadius = 25
            view.addSubview(circleView!)
            
            circleView!.snp.makeConstraints { make in
                make.centerX.equalTo(textLabel1.snp.trailing).offset(20)
                make.centerY.equalTo(textLabel1)
                make.width.height.equalTo(50)
            }
        }
    }
    
    private func removeCircleView() {
        circleView?.removeFromSuperview()
        circleView = nil
    }
    
    private func removeHelloLabel() {
        helloLabel?.removeFromSuperview()
        helloLabel = nil
    }
}
