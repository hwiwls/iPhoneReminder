//
//  DatePickerController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit
import SnapKit
import Then

class DatePickerController: BaseViewController {
    weak var delegate: DatePickerDelegate?

    let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .inline
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configLayout() {
        datePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configNavigaiton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        delegate?.didPick(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
