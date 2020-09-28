//
//  BarChartStatiscticViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 25.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class BarChartStatiscticViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        setUpNavigation()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Bar Chart"

        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonAction))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
}
