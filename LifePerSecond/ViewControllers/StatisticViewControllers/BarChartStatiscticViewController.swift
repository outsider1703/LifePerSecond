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
    private let barChartView: BarChartView = {
        let barChart = BarChartView()
        barChart.rightAxis.enabled = false
        barChart.setScaleEnabled(false)
        barChart.legend.enabled = false
        
        barChart.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        barChart.leftAxis.axisLineColor = .black
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.leftAxis.axisMinimum = 0
        
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        barChart.xAxis.axisLineColor = .black
        // barChart.xAxis.drawGridLinesEnabled = false
        
        return barChart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self

        view.backgroundColor = .systemBlue
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

    private func setupViews() {
        view.addSubview(statisticsDateSegmentedControl)
        statisticsDateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(98)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
        view.addSubview(barChartView)
        barChartView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: view.frame.width,
                                     height: view.frame.width ))
        }
    }
}
