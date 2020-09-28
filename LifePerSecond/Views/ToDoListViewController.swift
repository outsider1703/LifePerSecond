//
//  ToDoListViewController.swift
//  LifePerSecond
//
//  Created by Macbook on 24.09.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingCollectionView()
        settingNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func settingCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: (view.frame.height) / 10)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(DealForToDoListCollectionViewCell.self,
                                 forCellWithReuseIdentifier: DealForToDoListCollectionViewCell.reuseId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .systemPink
        
        view.addSubview(collectionView!)
    }
    
    private func settingNavigation() {
        navigationItem.title = "Goals"
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension ToDoListViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealForToDoListCollectionViewCell.reuseId, for: indexPath) as! DealForToDoListCollectionViewCell
        cell.backgroundColor = .systemTeal
        
        return cell
    }
}

