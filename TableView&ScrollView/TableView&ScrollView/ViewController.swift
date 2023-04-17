//
//  ViewController.swift
//  TableView&ScrollView
//
//  Created by 박다미 on 2023/04/17.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     1.scroll을 전체
     2.outView: UIView 를 넣고 전체 scroll에 맞게, 너비 같게,
     3.subview와 tableView를 넣고 subView는 높이까지 다 설정하고
      tabelview 도 높이 임의로 지정(후에 코드로 높이 조정)
     수정할때도 top은 바로 위에 놓을 객체에 맞추고 bottom은 감싸고 있는outView에 맞추기(control+drag)
     */
    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 스크롤 뷰 컨텐츠 크기 재설정
        let contentHeight = tableView.contentSize.height + subView1.frame.height
        if scrollView.contentSize != CGSize(width: scrollView.frame.width, height: contentHeight) {
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        cellCount += 1
        // 테이블 뷰의 높이
        let tableHeight = tableView.contentSize.height
        // 스크롤뷰의 contentSize를 tableHeight와 subView1의 높이를 합친 것으로 설정
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: tableHeight + subView1.frame.height)
        outView.frame.size.height = scrollView.contentSize.height
        // 테이블 뷰의 높이 증가
        tableView.frame.size.height = tableHeight
        print("테이블뷰셀 높이*개수: \(tableHeight)")
        
        print("스크롤뷰:\(scrollView.contentSize)")
        
        print("뷰: \(outView.frame.size.height)")
        
        print("테이블뷰: \(tableView.frame.size.height)")
        tableView.reloadData()
    }
    
}


extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as! TestTableViewCell
        cell.labelText.text = "인덱스 번호: \(indexPath.row + 1)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let contentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        if contentHeight > tableViewHeight {
            // 셀 추가 시 테이블 뷰 높이 추가
            var frame = tableView.frame
            frame.size.height += cell.frame.size.height
            tableView.frame = frame
            
            // 스크롤뷰 프레임이랑 컨텐츠 높이 맞춰야함 -> 컨텐츠 높이 재계산 후 스크롤 뷰 컨텐츠 크기 조정
            let contentHeight = tableView.contentSize.height + subView1.frame.height
            if scrollView.contentSize != CGSize(width: scrollView.frame.width, height: contentHeight) {
                scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0 // 셀 높이
    }
}
