//
//  FirstViewController.swift
//  pageKitTesting
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var startDate: Date?
    var endDate: Date?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let selectedDate = datePicker.date
           
           if let startDate = startDate, let endDate = endDate {
               // 이미 시작 날짜와 종료 날짜가 선택된 경우
               resetDateSelection()
               self.startDate = selectedDate
               startDateLabel.text = formatDate(selectedDate)
           } else if let startDate = startDate {
               // 시작 날짜가 선택된 경우
               if selectedDate < startDate {
                   // 선택한 날짜가 시작 날짜보다 이전인 경우 시작 날짜로 변경
                   self.startDate = selectedDate
                   startDateLabel.text = formatDate(selectedDate)
               } else {
                   // 선택한 날짜가 시작 날짜 이후인 경우 종료 날짜로 설정
                   self.endDate = selectedDate
                   endDateLabel.text = formatDate(selectedDate)
               }
           } else {
               // 시작 날짜가 선택되지 않은 경우
               self.startDate = selectedDate
               startDateLabel.text = formatDate(selectedDate)
           }
       
    }


   

     func resetDateSelection() {
         startDate = nil
         endDate = nil
         startDateLabel.text = "Start Date"
         endDateLabel.text = "End Date"
     }
 
            func formatDate(_ date: Date) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: date)
            }

            func applyDateSelection() {
                guard let startDate = startDate, let endDate = endDate else {
                    // 시작 날짜와 종료 날짜가 모두 선택되지 않았을 경우 처리
                    view.backgroundColor = UIColor.white
                    return
                }

            }
        }
