//
//  InformationForCellViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 28.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit
import Charts

class InformationForCellViewController: UIViewController, ChartViewDelegate {
    
    private let entriesSetterManaager = EntriesDataManager()
    private let timeSetterManaager = TimeSetterManager()
    private var personalTaskForCell: Task!
    
    private var allTime: Int64 {
        get { timeSetterManaager.getAllTimeFor(task: personalTaskForCell) }
        set { allTimeLabel.text = "All Time: \(newValue) min" }
    }
    private var specificTime: Int64 {
        get { timeSetterManaager.getSpecificTimeFor(personalTaskForCell, atSegmentFor: 1) }
        set { timeForSelectedSegment.text = "\(newValue) minutes" }
    }
    private var timeToday: Int64 {
        get { timeSetterManaager.getSpecificTimeFor(personalTaskForCell) }
        set { timeTodayLabel.text = "Time today: \(newValue) minutes" }
    }
    
    private let allTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    private let timeTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Time Today: "
        label.font = UIFont.italicSystemFont(ofSize: 22)
        return label
    }()
    
    private let statisticsDateSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Week", "Month", "Year"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(chooseTimeFor(segment:)), for: .valueChanged)
        return segment
    }()
    private let timeForSelectedSegment: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 22)
        return label
    }()
    
    private let plusLostTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(addLostTime), for: .touchUpInside)
        return button
    }()
    private let minusLostTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(removeLostTime), for: .touchUpInside)
        return button
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
        barChartView.data = entriesSetterManaager.creatingAndReceivingEntrieFor(personalTaskForCell)
        
        view.backgroundColor = .systemRed
        setTimerLabels()
        settingNavigation()
        setupViews()
    }
    
    @objc func chooseTimeFor(segment: UISegmentedControl) {
        specificTime = timeSetterManaager.getSpecificTimeFor(
            personalTaskForCell,
            atSegmentFor: segment.selectedSegmentIndex + 1
        )
        barChartView.data = entriesSetterManaager.creatingAndReceivingEntrieFor(
            personalTaskForCell,
            atSegment: segment.selectedSegmentIndex
        )
    }
    @objc func addLostTime() {
        editLostTimeAlert(title: "Add lost time", flag: "plus")
    }
    @objc func removeLostTime() {
        editLostTimeAlert(title: "Remove lost time", flag: nil)
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
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            CoreDataManager.shared.delete(self.personalTaskForCell)
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { (text) in
            text.text = self.personalTaskForCell.name
        }
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    private func editLostTimeAlert(title: String, flag: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            guard let addTime = alert.textFields?.first?.text, !addTime.isEmpty else { return }
            
            switch flag {
            case "plus":
                self.allTime += Int64(addTime) ?? 0
                self.specificTime += Int64(addTime) ?? 0
                self.timeToday += Int64(addTime) ?? 0
                CoreDataManager.shared.updateTime(self.personalTaskForCell, newTime: (Int64(addTime) ?? 0) * 60 )
            default:
                self.allTime -= Int64(addTime) ?? 0
                self.specificTime -= Int64(addTime) ?? 0
                self.timeToday -= Int64(addTime) ?? 0
                CoreDataManager.shared.updateTime(self.personalTaskForCell, newTime: -(Int64(addTime) ?? 0) * 60 )
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { (text) in
            text.placeholder = "minutes"
            text.keyboardType = .numberPad
        }
        present(alert, animated: true)
    }
}
//MARK: - Set Up Views and Navigation Controller
extension InformationForCellViewController {
    private func setTimerLabels() {
        allTimeLabel.text = "All Time: \(allTime) min"
        timeForSelectedSegment.text = "\(specificTime) minutes"
        timeTodayLabel.text = "Time today: \(timeToday) minutes"
    }
    private func settingNavigation() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self,
                                         action: #selector(editInformation))
        navigationItem.setRightBarButton(editButton, animated: false)
        let backButton = UIBarButtonItem(title: "Back",
                                         style: .done,
                                         target: self,
                                         action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
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
            make.top.equalToSuperview().offset(64)
            make.leading.equalTo(view).offset(8)
        }
        view.addSubview(timeTodayLabel)
        timeTodayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(allTimeLabel.snp.bottom).offset(8)
            make.leading.equalTo(8)
        }
        view.addSubview(statisticsDateSegmentedControl)
        statisticsDateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(timeTodayLabel.snp.bottom).offset(8)
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
        view.addSubview(barChartView)
        barChartView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: view.frame.width,
                                     height: view.frame.width ))
        }
    }
}
