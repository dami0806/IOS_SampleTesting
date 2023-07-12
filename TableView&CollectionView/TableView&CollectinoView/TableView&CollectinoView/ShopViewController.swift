//
//  ViewController.swift
//  TableView&CollectinoView
//
//  Created by 박다미 on 2023/07/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ShopViewController: UIViewController {
    private let shopTableView = UITableView()
    private let dummyData = [
        ["Image1", "Text1"],
        ["Image2", "Text2"],
        ["Image3", "Text3"],
        ["Image4", "Text4"],
        ["Image5", "Text5"]
    ]
    private var headerTitles: [String] = []  // 헤더의 제목을 저장하는 배열
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 첫 번째 헤더 제목을 네비게이션 타이틀로 설정
        if let firstTitle = headerTitles.first {
            navigationItem.title = firstTitle
        }
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        shopTableView.dataSource = self
        shopTableView.delegate = self
        shopTableView.register(ShopTableViewCell.self, forCellReuseIdentifier: "ShopTableViewCell")
        shopTableView.register(ShopTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "ShopTableHeaderView")
        
        view.addSubview(shopTableView)
    }
    
    private func setupConstraints() {
        shopTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateHeaderTitles() {
        // 헤더의 제목들을 업데이트
        headerTitles = dummyData.map { $0[1] }
    }
    
    private func setupNavigationTitle() {
        // 첫 번째 헤더 제목을 네비게이션 타이틀로 설정
        if let firstTitle = headerTitles.first {
            navigationItem.title = firstTitle
        }
    }
}

extension ShopViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as! ShopTableViewCell
        let data = dummyData[indexPath.section]
        cell.configure(image: data[0], text: data[1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ShopTableHeaderView") as! ShopTableHeaderView
        let sectionData = dummyData[section]
        let title = sectionData[1]
        headerView.configure(title: title)
        
        headerView.buttonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.handleButtonTap(section: section)
            })
            .disposed(by: disposeBag)
        
        return headerView
    }
    
    private func handleButtonTap(section: Int) {
        print("Button tapped for section \(section)")
    }
}

extension ShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
