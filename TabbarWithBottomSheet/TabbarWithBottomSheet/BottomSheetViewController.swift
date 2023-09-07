import UIKit
import SnapKit
//class BottomSheet1ViewController: BottomSheetViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        bottomSheetView.backgroundColor = .blue
//    }
//}
//
//class BottomSheet2ViewController: BottomSheetViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        bottomSheetView.backgroundColor = .green
//    }
//}
//
//class BottomSheet3ViewController: BottomSheetViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        bottomSheetView.backgroundColor = .orange
//    }
//}
class BottomSheetModel {
    var backgroundColor: UIColor
    var initialHeight: CGFloat
    var expandedHeight: CGFloat

    init(backgroundColor: UIColor, initialHeight: CGFloat, expandedHeight: CGFloat) {
        self.backgroundColor = backgroundColor
        self.initialHeight = initialHeight
        self.expandedHeight = expandedHeight
    }
}

// 모델 생성
let model1 = BottomSheetModel(backgroundColor: .blue, initialHeight: 300, expandedHeight: 900)
let model2 = BottomSheetModel(backgroundColor: .green, initialHeight: 300, expandedHeight: 900)
let model3 = BottomSheetModel(backgroundColor: .orange, initialHeight: 300, expandedHeight: 900)
class BottomSheetViewController: UIViewController {
    var model: BottomSheetModel?

    let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private var isExpanded = false
    private var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        bottomSheetView.addGestureRecognizer(tapGesture)
    }

    private func addSubviews() {
        view.addSubview(bottomSheetView)
    }

    private func configureConstraints() {
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(300) // 초기 높이를 설정
        }
    }

    @objc private func handleTap() {
        if isExpanded {
            collapseBottomSheet()
        } else {
            expandBottomSheet()
        }
    }

    private func expandBottomSheet() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            self.bottomSheetView.snp.updateConstraints { make in
                make.height.equalTo(900) // 확장할 높이를 설정
            }
            self.view.layoutIfNeeded()
        }

        animator?.startAnimation()
        isExpanded = true
    }

    private func collapseBottomSheet() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            self.bottomSheetView.snp.updateConstraints { make in
                make.height.equalTo(200) // 축소할 높이를 설정
            }
            self.view.layoutIfNeeded()
        }

        animator?.startAnimation()
        isExpanded = false
    }
}
class BottomSheet1ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모델 설정
        self.model = model1
        
        // 뷰 컨트롤러 구성
        bottomSheetView.backgroundColor = model?.backgroundColor
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(model?.initialHeight ?? 0)
        }
    }
}

class BottomSheet2ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모델 설정
        self.model = model2
        
        // 뷰 컨트롤러 구성
        bottomSheetView.backgroundColor = model?.backgroundColor
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(model?.initialHeight ?? 0)
        }
    }
}

class BottomSheet3ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모델 설정
        self.model = model3
        
        // 뷰 컨트롤러 구성
        bottomSheetView.backgroundColor = model?.backgroundColor
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(model?.initialHeight ?? 0)
        }
    }
}
