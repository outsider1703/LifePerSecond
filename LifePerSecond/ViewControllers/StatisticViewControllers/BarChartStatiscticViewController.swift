//
//  BarChartStatiscticViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 25.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit
import Charts

class BarChartStatiscticViewController: UIViewController, ChartViewDelegate {
    
    var toDoList: [Task] = []
    
    private let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        setUpBarChartView()
        setUpNavigation()
        setupViews()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Bar Chart"
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
    
    private func setUpBarChartView() {
        //  pieChartView.delegate = self
        
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
