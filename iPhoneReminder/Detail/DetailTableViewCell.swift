//
//  DetailTableViewCell.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit
import SnapKit
import Then

class DetailTableViewCell: UITableViewCell {
    let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "plus.circle.fill")
        $0.isUserInteractionEnabled = false
    }
    
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
        $0.isUserInteractionEnabled = false
    }
    
    let subtitleLabel = UILabel().then {
        $0.text = "subtitle"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemBlue
        $0.isHidden = true
        $0.isUserInteractionEnabled = false
    }
    
    let priorityLabel = UILabel().then {
        $0.text = "없음"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.isHidden = true
    }
    
    let priorityBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.showsMenuAsPrimaryAction = true
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
            titleLabel,
            logoImageView,
            subtitleLabel,
            priorityLabel,
            priorityBtn
        ])
    }
    
    func configLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
            $0.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        priorityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        priorityBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configView() {
        backgroundColor = .darkGray
        titleLabel.backgroundColor = .clear
        logoImageView.layer.cornerRadius = 10
    }
    
}
