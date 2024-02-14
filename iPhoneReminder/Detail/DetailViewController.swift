//
//  DetailViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit
import SnapKit
import Then

protocol DatePickerDelegate: AnyObject {
    func didPick(date: Date)
}

class DetailViewController: BaseViewController, DatePickerDelegate {
    
    let dayLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .white
    }
    
    let calendarBtn = UIButton().then {
        $0.trailingBtnConfiguration(title: "날짜", font: .systemFont(ofSize: 16), foregroundColor: .white, padding: 270, image: UIImage(systemName: "calendar.circle.fill")?.withTintColor(.red), imageSize: CGSize(width: 28, height: 28))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
        configView()
        configHierarchy()
        configLayout()
    }
    
    override func configView() {
        calendarBtn.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }

    @objc func calendarButtonTapped() {
            let datePickerVC = DatePickerController()
            datePickerVC.delegate = self
            let navController = UINavigationController(rootViewController: datePickerVC)
            present(navController, animated: true, completion: nil)
        }

        func didPick(date: Date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            dayLabel.text = formatter.string(from: date)
        }
   
    override func configHierarchy() {
        view.addSubviews([
            calendarBtn,
            dayLabel
        ])
    }
    
    override func configLayout() {
        calendarBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(calendarBtn.snp.top).offset(10)
            $0.leading.equalTo(calendarBtn.snp.leading).offset(50)
        }
    }
}
