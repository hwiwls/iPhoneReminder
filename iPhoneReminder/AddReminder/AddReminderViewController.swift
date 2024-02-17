//
//  AddReminderViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/15/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class AddReminderViewController: BaseViewController {
    var dateData = Date()
    var priorityData = ""
    let repository = ReminderRepository()
    
    let titleTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.text = "제목"
        $0.backgroundColor = .darkGray
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let memoTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.text = "메모"
        $0.backgroundColor = .darkGray
    }
    
    let detailBtn = UIButton().then {
        $0.trailingBtnConfiguration(title: "세부 사항", font: .systemFont(ofSize: 16), foregroundColor: .white, padding: 270, image: UIImage(systemName: "chevron.right")?.withTintColor(.white), imageSize: CGSize(width: 16, height: 20))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(dateReceivedNotification), name: NSNotification.Name("DateReceived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(priorityReceivedNotification), name: NSNotification.Name("PriorityReceived"), object: nil)
    }
    
    @objc func dateReceivedNotification(notification: NSNotification) {
        if let date = notification.userInfo?["date"] as? Date {
            dateData = date
        }
    }
    
    @objc func priorityReceivedNotification(notification: NSNotification) {
        if let priority = notification.userInfo?["priority"] as? String {
            priorityData = priority
        }
    }
    
    override func configView() {
        titleTextView.delegate = self
        memoTextView.delegate = self
        
        detailBtn.addTarget(self, action: #selector(detailBtnClicked), for: .touchUpInside)
        detailBtn.layer.cornerRadius = 10
    }
    
    @objc func detailBtnClicked() {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configHierarchy() {
        view.addSubviews([
            titleTextView,
            memoTextView,
            borderView,
            detailBtn
        ])
    }
    
    override func configLayout() {
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(40)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom)
            $0.leading.trailing.equalTo(titleTextView).inset(16)
            $0.height.equalTo(0.5)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(120)
        }
        
        detailBtn.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(memoTextView)
            $0.height.equalTo(45)
        }
    }
    
    func configNavigation() {
        navigationItem.title = "새로운 미리 알림"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func addButtonTapped() {
        let realm = try! Realm()
        
        print(realm.configuration.fileURL)
        
        let data = Reminder(title: titleTextView.text, memo: memoTextView.text, date: dateData, priority: priorityData)
        
        repository.createItem(data)
        dismiss(animated: true, completion: nil)
    }
}

extension AddReminderViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textView == titleTextView ? "제목" : "메모"
            textView.textColor = .lightGray
        }
    }
}
