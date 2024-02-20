//
//  MyListTableViewCell.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/20/24.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "list.bullet")
        $0.backgroundColor = .red
//        $0.isUserInteractionEnabled = false
    }
    
    let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
//        $0.isUserInteractionEnabled = false
    }
    
    let countLabel = UILabel().then {
        $0.text = "default"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
//        $0.isUserInteractionEnabled = false
    }
    
    let chevronImg = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
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
            countLabel,
            chevronImg
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
        
        chevronImg.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(20)
            $0.width.equalTo(15)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronImg.snp.leading).offset(-8)
        }
    }
    
    func configView() {
        backgroundColor = .darkGray
        titleLabel.backgroundColor = .clear
        logoImageView.layer.cornerRadius = logoImageView.frame.width / 2
    }
    
}
