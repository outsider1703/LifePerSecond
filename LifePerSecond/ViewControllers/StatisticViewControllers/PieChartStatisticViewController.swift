//
//  PieChartStatisticViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 25.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit
import Charts

class PieChartStatisticViewController: UIViewController, ChartViewDelegate {
    
    private let entriesSetterManaager = EntriesDataManager()
    private var toDoList: [Task] = []
    
    private let pieChartView: PieChartView = {
        let pieChart = PieChartView()
        pieChart.holeRadiusPercent = 0.3
        pieChart.transparentCircleRadiusPercent = 0.1
        pieChart.centerText = "Minuts"
        return pieChart
    }()
    
    private let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(chooseTimeFor(segment:)), for: .valueChanged)
        return segment
    }()
    @objc func chooseTimeFor(segment: UISegmentedControl) {
        pieChartView.data = entriesSetterManaager.creatingAndReceivingEntrieFor(
            tasks: toDoList,
            atSegmentFor: segment.selectedSegmentIndex
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = CoreDataManager.shared.fetchData()

        view.backgroundColor = .systemYellow
        setUpPieChartView()
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
    
    private func setUpPieChartView() {
        pieChartView.delegate = self
        pieChartView.data = entriesSetterManaager.creatingAndReceivingEntrieFor(tasks: toDoList)
    }
    
    private func setupViews() {
        view.addSubview(statisticsDateSegmentedControl)
        statisticsDateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(98)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
        view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: view.frame.width,
                                     height: view.frame.width ))
        }
    }
    
}
