//
//  DealForToDoListCollectionViewCell.swift
//  LifePerSecond
//
//  Created by Macbook on 24.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class DealForToDoListCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "Cell"
    
    private var personalTaskForCell: Task!
        
    private var timer: Timer?
    private var timerCounter: Int64 = 0 {
        didSet {
            if timerCounter < 60 {
                timerLabel.text = String(timerCounter)
            } else {
                let minuts = timerCounter / 60
                timerLabel.text = "\(minuts):\(timerCounter % 60)"
            }
        }
    }
    
    private let nameDealLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        return button
    }()
    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("STOP", for: .normal)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textAlignment = .center
        return label
    }()
    
    @objc func startButtonAction() {
        startButton.isHidden = true
        stopButton.isHidden = false
        
        startTimer()
    }
    
    @objc func stopButtonAction() {
        stopButton.isHidden = true
        startButton.isHidden = false
        
        CoreDataManager.shared.updateTime(personalTaskForCell, newTime: timerCounter)
        stopTimer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stopButton.isHidden = true
        
        setUpViews()
    }
    
    private func setUpViews() {
        addSubview(nameDealLabel)
        nameDealLabel.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width / 2)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(8)
        }
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width / 6)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(-80)
        }
        addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width / 6)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(-8)
        }
        self.addSubview(stopButton)
        stopButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width / 6)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- Timer
extension DealForToDoListCollectionViewCell {
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc func updateTimer() { timerCounter += 1 }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerCounter = 0
    }
}
//MARK:- Puplic Function for Setting UI  {{{
extension DealForToDoListCollectionViewCell {
    
    func preparePersonalCellFor(task: Task) {
        personalTaskForCell = task
        nameDealLabel.text = task.name
    }
    //MARK:- }}} Подумать как можно избежать передачи всего объекта для обнавления времени и стоит ли вообще
}
