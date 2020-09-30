//
//  InformationForCellViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 28.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class InformationForCellViewController: UIViewController {
    
    let allTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "All time: "
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        return segment
    }()
    let timeForSelectedSegment: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.italicSystemFont(ofSize: 22)
        return label
    }()
    let plusLostTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return button
    }()
    let minusLostTimeButton: UIButton = {
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
        navigationItem.title = "Goals"
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(editInformation))
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func editInformation() {
        
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(allTimeLabel)
        allTimeLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width - 128 , height: view.frame.height / 15))
            make.top.equalTo(view.safeAreaInsets.top).offset(64)
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
            make.leading.equalTo(allTimeLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: view.frame.height / 15, height: view.frame.height / 15))
        }
    }
}
