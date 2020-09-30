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
    
    let nameDealLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        return label
    }()
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        return button
    }()
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("STOP", for: .normal)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textAlignment = .center
        return label
    }()
    
    @objc func startButtonAction() {
        startButton.isHidden = true
        stopButton.isHidden = false
        print("Start")
    }
    
    @objc func stopButtonAction() {
        stopButton.isHidden = true
        startButton.isHidden = false
        print("Stop")
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
