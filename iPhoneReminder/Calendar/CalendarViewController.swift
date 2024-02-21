//
//  CalendarViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit
import SnapKit
import Then
import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {
    weak var delegate: CalendarDelegate?
    
    var list: Results<Reminder>!
    let repository = ReminderRepository()

    let calendar = FSCalendar().then {
        $0.scrollDirection = .vertical
        $0.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        view.addSubview(calendar)
    }
    
    override func configLayout() {
        calendar.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    override func configNavigaiton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        delegate?.didPick(date: calendar.selectedDate ?? Date())
        dismiss(animated: true, completion: nil)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        
        list = repository.getTodayReminder()
    }
}
