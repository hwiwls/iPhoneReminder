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
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
        configView()
        configHierarchy()
        configLayout()
    }
    
    override func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.backgroundColor = .clear
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
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
    }
   
    override func configHierarchy() {
        view.addSubviews([
            tableView
        ])
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        switch indexPath.section {
        case 0:
            cell.priorityLabel.isHidden = true
            if indexPath.row == 0 {
                cell.titleLabel.text = "날짜"
                cell.logoImageView.image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
                cell.logoImageView.backgroundColor = .red
            } else if indexPath.row == 1 {
                cell.titleLabel.text = "시간"
                cell.logoImageView.image = UIImage(systemName: "clock")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
                cell.logoImageView.backgroundColor = .blue
            }
        case 1:
            cell.titleLabel.text = "우선순위"
            cell.logoImageView.image = UIImage(systemName: "exclamationmark")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.white)
            cell.logoImageView.backgroundColor = .red
        default:
            break
        }
        
        return cell
    }
    
    
}
