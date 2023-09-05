import UIKit
import SnapKit
class BottomSheet1ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetView.backgroundColor = .blue
    }
}

class BottomSheet2ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetView.backgroundColor = .green
    }
}

class BottomSheet3ViewController: BottomSheetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetView.backgroundColor = .orange
    }
}
class BottomSheetViewController: UIViewController {
    
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
