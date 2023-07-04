//
//  ViewController.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import UIKit
import AVFoundation
import SDWebImage

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    let mainView = MainView()
    var presenter: MainViewPresenterProtocol?

    //MARK: - Private functions
    
    @objc private func getAudio() {
        var player: AVPlayer!
        let arrayUrl = presenter?.trans?.compactMap { $0.soundURL }
        let url = "https://vimbox-tts.skyeng.ru/api/v1/tts?text=%3Cspeak%3E%3Cphoneme+alphabet%3D%22ipa%22+ph%3D%22h%C9%9B%CB%88l%C9%99%CA%8A%22%3E%3C%2Fphoneme%3E%3C%2Fspeak%3E&lang=en&voice=female_1&isSsml=1"
        let playerItem = AVPlayerItem(url: URL(string: url)!)
    
        player = AVPlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = false
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        player.volume = 1.0
        player.play()
    print("Play")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.textField.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startSearch),
                                               name: Notification.Name("Test"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getAudio),
                                               name: Notification.Name("testSound"),
                                               object: nil)
    }
    
    @objc func startSearch(notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(0.5)), execute: { [weak self] in
            guard let self = self else { return }
            self.presenter?.getWord(word: self.mainView.textField.text ?? "")
        })
    }
}

//MARK: - Extension

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.arrayWords?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let imageUrl = (presenter?.trans?[indexPath.row].imageURL)!
        cell.translationLabel.text = presenter?.trans?[indexPath.row].translation.text
        cell.transcriptionLabel.text = presenter?.trans?[indexPath.row].transcription
        cell.mainImage.sd_setImage(with: URL(string: "https:" + imageUrl))
        return cell
    }
}

extension MainViewController: MainViewDelegate {
    func succes() {
        mainView.collectionView.reloadData()
    }
    
    func failure() {
        
    }
}

extension MainViewController: UITextFieldDelegate {

}

