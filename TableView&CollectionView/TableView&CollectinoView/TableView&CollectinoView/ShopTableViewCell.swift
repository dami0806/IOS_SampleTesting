//
//  ShopTableViewCell.swift
//  TableView&CollectinoView
//
//  Created by 박다미 on 2023/07/12.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ShopTableViewCell: UITableViewCell {
    private let subShopTableView = UITableView()
    private let dummySubData = [
        ["SubImage1", "SubText1"],
        ["SubImage2", "SubText2"],
        ["SubImage3", "SubText3"],
        ["SubImage4", "SubText4"],
        ["SubImage5", "SubText5"],
        ["SubImage6", "SubText6"],
        ["SubImage7", "SubText7"],
        ["SubImage8", "SubText8"],
        ["SubImage9", "SubText9"],
        ["SubImage10", "SubText10"]
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        subShopTableView.dataSource = self
        subShopTableView.delegate = self
        subShopTableView.register(SubShopTableViewCell.self, forCellReuseIdentifier: "SubShopTableViewCell")
        contentView.addSubview(subShopTableView)
    }
    
    private func setupConstraints() {
        subShopTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(image: String, text: String) {
        // 이미지와 텍스트를 설정하여 셀을 구성
    }
}

extension ShopTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubShopTableViewCell", for: indexPath) as! SubShopTableViewCell
        return cell
    }
}

extension ShopTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
