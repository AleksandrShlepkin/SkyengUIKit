//
//  MainCollectionView.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import UIKit

class MainCollectionView: UICollectionView {
    
   override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


