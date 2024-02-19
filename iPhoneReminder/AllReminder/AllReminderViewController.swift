//
//  AllReminderViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/16/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class AllReminderViewController: BaseViewController {
    
    let repository = ReminderRepository()
    
    let titleLabel = UILabel().then {
        $0.text = "전체"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = .white
    }
    
    let tableView = UITableView()
    
    var list: Results<Reminder>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        list = repository.fetch()
        
        tableView.reloadData()
    }
    
    override func configView() {
        view.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.backgroundColor = .clear
        tableView.register(AllReminderTableViewCell.self, forCellReuseIdentifier: "AllReminderTableViewCell")
    }
    
    override func configHierarchy() {
        view.addSubviews([
            titleLabel,
            tableView
        ])
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func configNavigaiton() {
        let sortAndFilterClosure = { (action: UIAction) in
            switch action.title {
            case "마감일 순으로 보기":
                self.list = self.repository.fetchSortedByDate()
            case "제목 순으로 보기":
                self.list = self.repository.fetchSortedByTitle()
            case "우선순위 낮은만 보기":
                self.list = self.repository.fetchWithLowPriority()
            default:
                break
            }
            self.tableView.reloadData()
        }
        
        let menu = UIMenu(title: "정렬 및 필터링", children: [
            UIAction(title: "마감일 순으로 보기", handler: sortAndFilterClosure),
            UIAction(title: "제목 순으로 보기", handler: sortAndFilterClosure),
            UIAction(title: "우선순위 낮은만 보기", handler: sortAndFilterClosure)
        ])
        
        let item = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
        navigationItem.rightBarButtonItem = item
    }

    func formatDate(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        if let date = date {
            return formatter.string(from: date)
        } else {
            return formatter.string(from: Date())
        }
    }
}

extension AllReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllReminderTableViewCell", for: indexPath) as! AllReminderTableViewCell
        cell.selectionStyle = .none
        
        let row = list[indexPath.row]
        cell.configure(with: row, formatDate: formatDate)
        
        if let image = loadImageToDocument(filename: "\(row.id)") {
            cell.todoImageView.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.deleteItem(list[indexPath.row])
            tableView.reloadData()
        }
    }
}
