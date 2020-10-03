//
//  PieChartStatisticViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 25.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class PieChartStatisticViewController: UIViewController {
    
    private let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        setUpNavigation()
        setupViews()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Pie Chart"
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(statisticsDateSegmentedControl)
        statisticsDateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(98)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
    }
    
}
