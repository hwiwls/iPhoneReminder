//
//  ScneduledViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/20/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class ScheduledViewController: BaseViewController {
    let realm = try! Realm()
    var list: Results<Reminder>!
    let repository = ReminderRepository()

    let titleLabel = UILabel().then {
        $0.text = "예정"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = .white
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let start = Calendar.current.startOfDay(for: Date())
        
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        let predicate = NSPredicate(format: "date < %@ || date > %@", start as NSDate, end as NSDate)
        
        list = realm.objects(Reminder.self).filter(predicate)
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

extension ScheduledViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllReminderTableViewCell", for: indexPath) as! AllReminderTableViewCell
        cell.selectionStyle = .none
        
        let row = list[indexPath.row]
        
        print(list[indexPath.row])
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
