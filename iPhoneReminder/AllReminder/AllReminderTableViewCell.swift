//
//  AllReminderTableViewCell.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/16/24.
//

import UIKit
import SnapKit
import Then

class AllReminderTableViewCell: UITableViewCell {
    
    private let repository = ReminderRepository()
    
    private var reminder: Reminder?
    
    let isDoneBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        $0.setImage(UIImage(systemName: "button.programmable")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .selected)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    let memoLabel = UILabel().then {
        $0.text = "memo"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .lightGray
    }
    
    let dateLabel = UILabel().then {
        $0.text = "date"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemBlue
    }
    
    let priorityLabel = UILabel().then {
        $0.text = "priority"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemBlue
    }
    
    let todoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        contentView.addSubviews([
            isDoneBtn,
            titleLabel,
            memoLabel,
            dateLabel,
            priorityLabel,
            todoImageView
        ])
    }
    
    func configLayout() {
        isDoneBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(isDoneBtn)
            $0.leading.equalTo(isDoneBtn.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.equalTo(titleLabel)
        }
        
        priorityLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
            $0.bottom.equalTo(dateLabel)
        }
        
        todoImageView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configView() {
        backgroundColor = .clear
        isDoneBtn.addTarget(self, action: #selector(handleCheckMarkButton), for: .touchUpInside)
    }
    
    @objc func handleCheckMarkButton() {
        isDoneBtn.isSelected = !isDoneBtn.isSelected
        if let reminder = self.reminder {
            repository.updateItemIsDone(id: reminder.id, isDone: isDoneBtn.isSelected)
        }
    }
    
    func setup(with reminder: Reminder) {
        self.reminder = reminder
        isDoneBtn.isSelected = reminder.isDone
    }
    
    func configure(with reminder: Reminder, formatDate: (Date?) -> String) {
        titleLabel.text = reminder.reminderTitle
        memoLabel.text = reminder.memo
        if reminder.date != nil {
            dateLabel.text = formatDate(reminder.date)
        } else {
            dateLabel.isHidden = true
        }
        priorityLabel.text = reminder.priority
        setup(with: reminder)
        
        switch reminder.priority {
        case "높음":
        priorityLabel.text = "!!!" + (reminder.priority ?? "")
        case "중간":
        priorityLabel.text = "!!" + (reminder.priority ?? "")
        case "낮음":
        priorityLabel.text = "!" + (reminder.priority ?? "")
        default:
            priorityLabel.text = reminder.priority
        }
    }
}
