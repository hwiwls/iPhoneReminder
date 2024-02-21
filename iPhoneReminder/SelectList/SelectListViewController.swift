//
//  SelectListViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/21/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class SelectListViewController: BaseViewController {
    
    let repository = ReminderRepository()
    var list: Results<MyList>!
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        list = repository.fetchMyList()
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
    
    override func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.backgroundColor = .clear
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: "MyListTableViewCell")
    }
}

extension SelectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListTableViewCell", for: indexPath) as! MyListTableViewCell
        
        let row = list[indexPath.row]
        
        cell.titleLabel.text = row.name
        cell.countLabel.text = "\(row.detail.count)"
        let color = UIColor(hexCode: row.color)
        cell.containerView.backgroundColor = color

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = list[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("didSelectList"), object: nil, userInfo: ["title": row])
        navigationController?.popViewController(animated: true)
    }
    
    
}
