//
//  ViewController.swift
//  FscalendarTesting
//
//  Created by 박다미 on 2023/07/22.
//
import UIKit
import FSCalendar
import SnapKit

// 일정 이벤트 구조체
struct ScheduleEvent {
    let date: String?
    let description: String?
    let color: String?
}
class ViewController: UIViewController {
    
    private let calendar = FSCalendar()
    
    // 더미 데이터
    //    private let dummyData: [String: [String]] = [
    //        "2023-06-12": ["a", "b"],
    //        "2023-07-10": ["c", "d", "e"]
    //    ]
    // 더미 데이터
    private var list: [ScheduleEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list.append(ScheduleEvent(date: "2023-07-09", description: "축구 경기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-11", description: "스터디",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-01", description: "야구 경기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-10", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "집에 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        // FSCalendar 설정
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(MyCalendarCell.self, forCellReuseIdentifier: "cell") // 커스텀 셀 클래스 등록
        view.addSubview(calendar)
        
        // 오토레이아웃 설정
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        
        // 달력의 스타일 설정 (이전 코드에서 설정한 스타일 유지)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.todayColor = .systemBlue
        calendar.backgroundColor = .white
    }
}

extension ViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    
    // 커스텀 셀을 사용하여 데이터를 표시
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as! MyCalendarCell
        
        // 해당 날짜의 데이터를 가져와서 정렬
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        let eventsForDate = list.filter { $0.date == dateString }
        cell.updateTableViewData(eventsForDate)
        
        return cell
    }
}

class MyCalendarCell: FSCalendarCell, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // 테이블 뷰 데이터 소스
    private var tableData: [ScheduleEvent] = []
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
                       make.top.equalTo(contentView.snp.centerY)
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTableViewData(_ data: [ScheduleEvent]) {
        tableData = data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = UIFont.systemFont(ofSize: 8)
        cell.textLabel?.text = tableData[indexPath.row].description
       // cell.backgroundColor = UIColor(named: tableData[indexPath.row].color ?? "")
        let hexCode = tableData[indexPath.row].color
        let color = UIColor(hexCode: hexCode ?? "FFFFF")
        cell.backgroundColor = color
        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.width) / CGFloat(tableData.count) // 달력 셀 내에서 셀의 높이를 조정
    }
}


//color String-> UIColor
extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
