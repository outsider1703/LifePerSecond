//
//  PieChartStatisticViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 25.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class PieChartStatisticViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        setUpNavigation()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Pie Chart"
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
}
