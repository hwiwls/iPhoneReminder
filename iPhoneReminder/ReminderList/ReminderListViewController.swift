//
//  ViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

class ReminderViewController: BaseViewController {
    let realm = try! Realm()
    let repository = ReminderRepository()
    var list: Results<MyList>!
    
    let cellTitles = ["오늘", "예정", "전체", "완료됨"]
    let cellImages = [UIImage(systemName: "calendar.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.blue), UIImage(systemName: "calendar.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red), UIImage(systemName: "envelope.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    private let myListLabel = UILabel().then {
        $0.text = "나의 목록"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100)).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.barTintColor = .clear
    }

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
        print(realm.configuration.fileURL ?? "")
        
        configToolbar()
        
        list = realm.objects(MyList.self)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name(rawValue: "AddReminderDismissed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "AddMyListDismissed"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    override func configHierarchy() {
        view.addSubviews([
            collectionView,
            myListLabel,
            tableView,
            toolBar
        ])
    }

    override func configView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReminderListCollectionViewCell.self, forCellWithReuseIdentifier: "ReminderListCollectionViewCell")
        collectionView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.backgroundColor = .clear
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: "MyListTableViewCell")
        
    }

    func configToolbar() {
        let toolbarItem1 = UIBarButtonItem(title: "새로운 미리 알림", style: .plain, target: self, action: #selector(addReminderBtn))
        let toolbarItem2 = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListBtn))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let items = [toolbarItem1, flexibleSpace, toolbarItem2]
        
        self.toolBar.setItems(items, animated: true)
    }

    override func configLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(250)
        }
        
        myListLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(12)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.height.equalTo(22)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(myListLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        toolBar.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    @objc func addReminderBtn() {
        let vc = AddReminderViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true)
    }
    
    @objc func addListBtn() {
        let vc = AddMyListViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true)
    }
}

extension ReminderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderListCollectionViewCell", for: indexPath) as! ReminderListCollectionViewCell
        
        cell.titleLabel.text = cellTitles[indexPath.item]
        cell.imageView.image = cellImages[indexPath.item]
        
        if indexPath.item == 0 {
            let itemCount = repository.fetchTodayItems().count
            cell.countLabel.text = "\(itemCount)"
        } else if indexPath.item == 1 {
            let itemCount = repository.fetch().count - repository.fetchTodayItems().count
            cell.countLabel.text = "\(itemCount)"
        } else if indexPath.item == 2 {
            let itemCount = repository.fetch().count
            cell.countLabel.text = "\(itemCount)"
        } else if indexPath.item == 3 {
            let itemCount = repository.fetchIsDoneItems().count
            cell.countLabel.text = "\(itemCount)"
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = TodayReminderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 1 {
            let vc = ScheduledViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 2 {
            let vc = AllReminderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    
}
