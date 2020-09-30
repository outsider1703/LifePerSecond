//
//  ViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 21.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class BigBlackButtonViewController: UIViewController {
    
    private let bigBlackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        button.addTarget(self, action: #selector(goToDoList), for: .touchUpInside)
        return button
    }()
    
    private let statisticsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Statistics", for: .normal)
        
        button.addTarget(self, action: #selector(goToStatisticsVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        addSubview()
    }
    
    @objc func goToDoList() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: (view.frame.height) / 10)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let toDoVC = ToDoListCollectionViewController(collectionViewLayout: layout)
        present(UINavigationController(rootViewController: toDoVC), animated: true)
    }
    @objc func goToStatisticsVC() {
        let tapBarVC = UITabBarController()
        
        let pieChart = UINavigationController(rootViewController: PieChartStatisticViewController())
        let barChart = UINavigationController(rootViewController: BarChartStatiscticViewController()) 
        
        pieChart.title = "Pie"
        barChart.title = "Bar"
        
        tapBarVC.setViewControllers([pieChart, barChart], animated: false)
        
        guard let items = tapBarVC.tabBar.items else { return }
        
        let images = ["chart.pie.fill", "chart.bar.fill"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tapBarVC.modalPresentationStyle = .fullScreen
        tapBarVC.modalTransitionStyle = .crossDissolve
        
        present(tapBarVC, animated: true)
    }
    
    private func addSubview() {
        view.addSubview(bigBlackButton)
        view.addSubview(statisticsButton)
        
        setupConstraints()
        setCornerRadiusForButtons()
    }
    
    private func setupConstraints() {
        bigBlackButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: view.frame.width / 2,
                                     height: view.frame.width / 2))
        }
        statisticsButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(16)
            make.bottom.equalTo(view).offset(-32)
            make.size.equalTo(CGSize(width: view.frame.width / 4, height: view.frame.width / 4))
        }
    }
    
    private func setCornerRadiusForButtons() {
        bigBlackButton.layer.cornerRadius = (view.frame.width / 2) / 2
        statisticsButton.layer.cornerRadius = (view.frame.width / 4) / 2
    }
    
}

