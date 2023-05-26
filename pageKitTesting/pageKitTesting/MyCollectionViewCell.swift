//
//  MyCollectionViewCell.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    // segmentControl의 인덱스에 따라 열의 개수를 조절하기 위한 메서드
      func setColumnCount(_ count: Int) {
          // 열의 개수(count)에 따라 셀의 레이아웃을 업데이트
          // 예시로 한 줄에 count 개수만큼의 셀이 표시되도록 구현
          // 필요에 따라 셀의 크기나 배치 방식을 조절할 수 있습니다.
          let cellWidth = contentView.frame.size.width / CGFloat(count)
          let cellHeight = contentView.frame.size.height
          let cellSize = CGSize(width: cellWidth, height: cellHeight)
          frame.size = cellSize
      }
}
