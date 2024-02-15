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
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
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
            titleLabel
        ])
    }
    
    func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
    }
    
    func configView() {
        backgroundColor = .clear
    }
    
}
