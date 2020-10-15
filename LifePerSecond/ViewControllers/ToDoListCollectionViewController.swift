//
//  ToDoListCollectionViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 30.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class ToDoListCollectionViewController: UICollectionViewController {
    
    var toDoList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 128/255, green: 24/255, blue: 24/255, alpha: 1)
        collectionView.register(DealForToDoListCollectionViewCell.self,
                                forCellWithReuseIdentifier: DealForToDoListCollectionViewCell.reuseId)
        
        settingNavigation()
        toDoList = CoreDataManager.shared.fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let informationVC = InformationForCellViewController()
        
        informationVC.preparePersonalCellFor(task: toDoList[indexPath.item])
        
        present(UINavigationController(rootViewController: informationVC), animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealForToDoListCollectionViewCell.reuseId,
                                                      for: indexPath) as! DealForToDoListCollectionViewCell
        
        let startDate = UserDefaults.standard.object(forKey: toDoList[indexPath.item].name!) as? Date
        cell.preparePersonalCellFor(task: toDoList[indexPath.item], and: startDate)
        
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
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNewDeal))
        barButton.tintColor = .white
        navigationItem.rightBarButtonItem = barButton
        
    }
    @objc func addNewDeal() {
        addNewDealAlert(title: "New Goals")
    }
    
}

//MARK: - Alert
extension ToDoListCollectionViewController {
    
    private func addNewDealAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Achieve This", style: .default) { [unowned self] _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            
            guard let taskObjectforData = CoreDataManager.shared.getAnObject() else { return }
            taskObjectforData.name = task
            
            self.toDoList.append(taskObjectforData)
            
            let indexPath = IndexPath(row: self.toDoList.count - 1, section: 0)
            self.collectionView.insertItems(at: [indexPath])
            
            CoreDataManager.shared.save(taskObjectforData)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField()
        
        present(alert, animated: true)
    }
}


