//
//  ViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/14/24.
//

import UIKit
import SnapKit

class ReminderViewController: BaseViewController {
    let cellTitles = ["오늘", "예정", "전체", "완료됨"]
    let cellImages = [UIImage(systemName: "calendar.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.blue), UIImage(systemName: "calendar.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red), UIImage(systemName: "envelope.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(width: (view.frame.width - 16*3)/2, height: 88)
            $0.minimumLineSpacing = 16
            $0.minimumInteritemSpacing = 16
            $0.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        return layout
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configView()
        configLayout()
    }
    
    override func configHierarchy() {
        view.addSubviews([
            collectionView
        ])
    }

    override func configView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReminderListCollectionViewCell.self, forCellWithReuseIdentifier: "ReminderListCollectionViewCell")
        collectionView.backgroundColor = .clear
    }
    
    override func configLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(250)
        }
    }
}

extension ReminderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderListCollectionViewCell", for: indexPath) as! ReminderListCollectionViewCell
        
        cell.titleLabel.text = cellTitles[indexPath.row]
        
        cell.imageView.image = cellImages[indexPath.row]

        return cell
    }
    
    
}

