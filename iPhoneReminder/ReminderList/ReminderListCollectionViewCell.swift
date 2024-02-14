//
//  ReminderListCollectionViewCell.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/14/24.
//

import UIKit
import SnapKit
import Then

class ReminderListCollectionViewCell: UICollectionViewCell {
    let backgroundColoredView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 10
    }
    
    let imageView = UIImageView().then {
        $0.image = UIImage(systemName: "calendar.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.blue)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "오늘"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .lightGray
    }
    
    let countLabel = UILabel().then {
        $0.text = "0"
        $0.font = .boldSystemFont(ofSize: 28)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        contentView.addSubviews([
            backgroundColoredView,
            imageView,
            titleLabel,
            countLabel
        ])
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.leading.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        backgroundColoredView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
