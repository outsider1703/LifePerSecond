//
//  InformationForCellViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 28.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class InformationForCellViewController: UIViewController {
    
    private var personalTaskForCell: Task!
    
    private let allTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "All time: "
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    private let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        return segment
    }()
    private let timeForSelectedSegment: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.italicSystemFont(ofSize: 22)
        return label
    }()
    private let plusLostTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return button
    }()
    private let minusLostTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        settingNavigation()
        setupViews()
    }
    
    private func settingNavigation() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self,
                                         action: #selector(editInformation))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .close,
                                           target: self,
                                           action: #selector(deleteTask))
        navigationItem.setRightBarButtonItems([deleteButton, editButton], animated: false)
        let backButton = UIBarButtonItem(title: "Back",
                                         style: .done,
                                         target: self,
                                         action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func deleteTask() {
        CoreDataManager.shared.delete(personalTaskForCell)
    }
    @objc func editInformation() {
        editInfoAlert(title: "Edit Name")
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(allTimeLabel)
        allTimeLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width - 128 , height: view.frame.height / 15))
            make.top.equalToSuperview().offset(64)
            make.leading.equalTo(view).offset(8)
        }
        view.addSubview(statisticsDateSegmentedControl)
        statisticsDateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(allTimeLabel.snp.bottom).offset(8)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
        view.addSubview(timeForSelectedSegment)
        timeForSelectedSegment.snp.makeConstraints { (make) in
            make.top.equalTo(statisticsDateSegmentedControl.snp.bottom).offset(8)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
        view.addSubview(plusLostTimeButton)
        plusLostTimeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.size.equalTo(CGSize(width: view.frame.height / 15, height: view.frame.height / 15))
            make.trailing.equalTo(view).offset(-8)
        }
        view.addSubview(minusLostTimeButton)
        minusLostTimeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.trailing.equalTo(plusLostTimeButton.snp.leading).offset(0)
            make.size.equalTo(CGSize(width: view.frame.height / 15, height: view.frame.height / 15))
        }
    }
}
//MARK:- Puplic Function for Setting UI
extension InformationForCellViewController {
    
    func preparePersonalCellFor(task: Task) {
        personalTaskForCell = task
        navigationItem.title = task.name
    }
}

//MARK: - Alerts
extension InformationForCellViewController {
    
    private func editInfoAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Edit", style: .default) { [unowned self] _ in
            guard let newName = alert.textFields?.first?.text, !newName.isEmpty else { return }
            CoreDataManager.shared.editName(self.personalTaskForCell, newName: newName)
            self.navigationItem.title = newName
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { (text) in
            text.text = self.personalTaskForCell.name
        }
        present(alert, animated: true)
    }
    
}
