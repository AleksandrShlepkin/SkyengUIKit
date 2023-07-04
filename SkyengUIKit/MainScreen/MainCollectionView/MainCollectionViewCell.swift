//
//  MainCollectionViewCell.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import UIKit
import AVFoundation

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private properties
    
    private(set) var translationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var transcriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var mainImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Constraction

    override init(frame: CGRect) {
        super.init(frame: frame)
        playButton.addTarget(self, action: #selector(playSoundFunc), for: .touchUpInside)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }
    
    //MARK: - Private fuction
    
    @objc private func playSoundFunc(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("testSound"), object: nil)
    }
    
    private func setupView() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        addSubview(translationLabel)
        addSubview(transcriptionLabel)
        addSubview(playButton)
        addSubview(mainImage)
        
        NSLayoutConstraint.activate([
            
            translationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            translationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            translationLabel.heightAnchor.constraint(equalToConstant: 20),
            translationLabel.widthAnchor.constraint(equalToConstant: 40),
            
            transcriptionLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 10),
            transcriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            transcriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            transcriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            playButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playButton.leadingAnchor.constraint(equalTo: translationLabel.trailingAnchor, constant: 10),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playButton.heightAnchor.constraint(equalToConstant: 25),
            playButton.widthAnchor.constraint(equalToConstant: 25),
            
            mainImage.topAnchor.constraint(equalTo: transcriptionLabel.bottomAnchor, constant: 10),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainImage.heightAnchor.constraint(equalToConstant: 30),
            mainImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

