//
//  AddMyListViewController.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/20/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class AddMyListViewController: BaseViewController, UITextFieldDelegate {
    let repository = ReminderRepository()
    
    private let listNameBackgroundview = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    let containerView = UIView().then {
        $0.backgroundColor = .red
    }
    
    lazy var myListImageView = UIImageView().then {
        $0.image = UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
    }
    
    lazy var myListNameTextField = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.placeholder = "목록 이름"
        $0.textColor = containerView.backgroundColor
    }
    
    private let selectColorBackgroundview = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    private let stackview = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
    }
    
    private let redBtn = UIButton().then {
        $0.backgroundColor = .red
        $0.clipsToBounds = true
    }
    
    private let orangeBtn = UIButton().then {
        $0.backgroundColor = .orange
        $0.clipsToBounds = true
    }
    
    private let yellowBtn = UIButton().then {
        $0.backgroundColor = .yellow
        $0.clipsToBounds = true
    }
    
    private let greenBtn = UIButton().then {
        $0.backgroundColor = .green
        $0.clipsToBounds = true
    }
    
    private let blueBtn = UIButton().then {
        $0.backgroundColor = .blue
        $0.clipsToBounds = true
    }
    
    private let purpleBtn = UIButton().then {
        $0.backgroundColor = .purple
        $0.clipsToBounds = true
    }
    
    private let brownBtn = UIButton().then {
        $0.backgroundColor = .brown
        $0.clipsToBounds = true
    }
    
    lazy var buttonArray = [redBtn, orangeBtn, yellowBtn, greenBtn, blueBtn, purpleBtn, brownBtn]

    override func viewDidLoad() {
        super.viewDidLoad()
        let customDarkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        view.backgroundColor = customDarkGray
    }
    
    override func configView() {
        listNameBackgroundview.layer.cornerRadius = 10
        selectColorBackgroundview.layer.cornerRadius = 10
        myListNameTextField.layer.cornerRadius = 10
        myListNameTextField.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for button in self.buttonArray {
                button.layer.cornerRadius = button.frame.width / 2
            }
            
            containerView.layer.cornerRadius = containerView.frame.width / 2
        }
        
        for button in buttonArray {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        containerView.backgroundColor = sender.backgroundColor
        myListNameTextField.textColor = sender.backgroundColor
    }
    
    override func configHierarchy() {
        view.addSubviews([
            listNameBackgroundview,
            selectColorBackgroundview
        ])
        
        listNameBackgroundview.addSubviews([
            containerView,
            myListImageView,
            myListNameTextField,
        ])
        
        selectColorBackgroundview.addSubview(stackview)
        
        stackview.addArrangedSubviews([
            redBtn,
            orangeBtn,
            yellowBtn,
            greenBtn,
            blueBtn,
            purpleBtn,
            brownBtn
        ])
    }
    
    override func configLayout() {
        listNameBackgroundview.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(200)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        myListImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalTo(containerView)
        }
        
        myListNameTextField.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        selectColorBackgroundview.snp.makeConstraints {
            $0.top.equalTo(listNameBackgroundview.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(80)
        }
        
        stackview.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(18)
        }
        
        redBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

        orangeBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }
        
        yellowBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

        greenBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

        blueBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

        purpleBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

        brownBtn.snp.makeConstraints {
            $0.height.equalTo(stackview.snp.height)
        }

    }
    
    override func configNavigaiton() {
        navigationItem.title = "새로운 미리 알림"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func addButtonTapped() {
        if myListNameTextField.text ==  "" {
            self.view.makeToast(nil, duration: 1.0, position: .center, title: "제목을 입력해주세요")
        } else {
            let data = MyList(name: myListNameTextField.text ?? "", regDate: Date(), color: containerView.backgroundColor?.hexString ?? "FFFFFF")

            repository.createMyList(data)
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddMyListDismissed"), object: nil)
        }
    }
}
