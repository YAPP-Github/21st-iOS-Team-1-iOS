//
//  CategoryCollectionView.swift
//  FindTown
//
//  Created by 이호영 on 2023/01/10.
//

import UIKit

final class CategoryCollectionView: UICollectionView {
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: CategoryCollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        allowsMultipleSelection = false
        register(MapCategoryCollectionViewCell.self,
                 forCellWithReuseIdentifier: MapCategoryCollectionViewCell.reuseIdentifier)
    }

}
