//
//  SubShopCollectionViewCell.swift
//  TableView&CollectinoView
//
//  Created by 박다미 on 2023/07/12.
//
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SubShopCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    } 
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
    }
    
    func configure(image: String, text: String) {
        imageView.image = UIImage(named: image)
        label.text = text
    }
}
