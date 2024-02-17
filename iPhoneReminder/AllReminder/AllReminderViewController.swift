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
        tableView.rowHeight = 45
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
    

}

extension AllReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllReminderTableViewCell", for: indexPath) as! AllReminderTableViewCell
        
        cell.selectionStyle = .none
        
        let row = list[indexPath.row]
        cell.titleLabel.text = "할 일: \(row.title), 마감일: \(row.date ?? Date())"
        
        return cell
    }
    
    
}
