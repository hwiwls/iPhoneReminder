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
    var selectedDate: Date?
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
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
        selectedDate = date
        /*
         tableView.reloadData()를 하면 UIMenu 기능이 안됨
         => tableView.reloadData()를 호출하면, 셀을 새로 그리는 과정에서 셀의 UIMenu 설정이 초기화.
            그런데 UIMenu는 기본적으로 사용자가 셀에 대해 특정 동작 (예: 길게 누르기)을 수행할 때마다 생성.
            따라서 UIMenu는 셀이 화면에 표시될 때마다 자동으로 다시 생성되지 않음.
            이 문제를 해결하려면, 셀이 화면에 표시될 때마다 UIMenu를 설정해주어야 하는데, 이것보다는 업데이트 하고자 하는 날짜 cell만 업데이트 하는 것이 맞다고 여겨짐
         */
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        NotificationCenter.default.post(name: Notification.Name("DateReceived"), object: nil, userInfo: ["date": date])
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            cell.priorityLabel.isHidden = true
            cell.priorityBtn.isHidden = true
            if indexPath.row == 0 {
                cell.titleLabel.text = "날짜"
                cell.logoImageView.image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
                cell.logoImageView.backgroundColor = .red
                if let date = selectedDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy년 MM월 dd일"
                    let dateString = formatter.string(from: date)
                    cell.subtitleLabel.text = dateString
                    cell.subtitleLabel.isHidden = false
                }
            } else if indexPath.row == 1 {
                cell.subtitleLabel.isHidden = true
                cell.titleLabel.text = "시간"
                cell.logoImageView.image = UIImage(systemName: "clock")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
                cell.logoImageView.backgroundColor = .blue
            }
        case 1:
            cell.priorityLabel.isHidden = false
            cell.titleLabel.text = "우선순위"
            cell.logoImageView.image = UIImage(systemName: "exclamationmark")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.white)
            cell.logoImageView.backgroundColor = .red
            
        case 2:
            cell.titleLabel.text = "이미지 등록"
            cell.logoImageView.image = UIImage(systemName: "photo")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.white)
            cell.logoImageView.backgroundColor = .systemBlue
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let datePickerVC = DatePickerController()
                datePickerVC.delegate = self
                let navController = UINavigationController(rootViewController: datePickerVC)
                present(navController, animated: true, completion: nil)
            } else if indexPath.row == 1 {
                print("두번째 cell")
            }
        } else if indexPath.section == 2 {
            print("이미지 등록하기")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = cell as! DetailTableViewCell
            
            let priorityButtonClosure = { (action: UIAction) in
                cell.priorityLabel.text = action.title
                NotificationCenter.default.post(name: Notification.Name("PriorityReceived"), object: nil, userInfo: ["priority": action.title])
            }
            
            let menu = UIMenu(title: "우선순위 선택", children: [
                UIAction(title: "없음", handler: priorityButtonClosure),
                UIAction(title: "낮음", handler: priorityButtonClosure),
                UIAction(title: "중간", handler: priorityButtonClosure),
                UIAction(title: "높음", handler: priorityButtonClosure)
            ])
            
            cell.priorityBtn.menu = menu
        }
    }
}
