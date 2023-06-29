//
//  MainView.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - Private properties
    
    var presenter: MainViewPresenterProtocol?
    
    private(set) var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints =  false
        field.font = UIFont.systemFont(ofSize: 22)
        field.textColor = .black
        field.backgroundColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Search",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        field.layer.cornerRadius = 5
        return field
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25)
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private(set) var collectionView: MainCollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = MainCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    //MARK: - Constraction
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
        textField.addTarget(self, action: #selector(searchWord), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Functions
    
    @objc func searchWord() {
        NotificationCenter.default.post(name: Notification.Name("Test"), object: nil)
    }

    //MARK: - Private Functions
    
    private func setupView() {
        backgroundColor = .systemGray6
        addSubview(textField)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


