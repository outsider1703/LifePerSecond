//
//  ToDoListCollectionViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 30.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class ToDoListCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemPink
        collectionView.register(DealForToDoListCollectionViewCell.self,
                                forCellWithReuseIdentifier: DealForToDoListCollectionViewCell.reuseId)
        settingNavigation()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let informationVC = InformationForCellViewController()
        present(UINavigationController(rootViewController: informationVC), animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealForToDoListCollectionViewCell.reuseId,
                                                      for: indexPath) as! DealForToDoListCollectionViewCell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    }
    
    //MARK: Private Function
    private func settingNavigation() {
        navigationItem.title = "Goals"
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewDeal))
    }
    @objc func addNewDeal() {
        addNewDealAlert(title: "New Goals")
    }
    
    private func addNewDealAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField()
        
        present(alert, animated: true)
    }
    
}

