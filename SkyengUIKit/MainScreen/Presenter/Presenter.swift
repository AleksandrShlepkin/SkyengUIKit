//
//  Presenter.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getWord(word: String)
    var arrayWords: [WordsModelElement]? { get set }
    var trans: [Meaning]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var arrayWords: [WordsModelElement]?
    let networkService: NetworkServiceProtocol
    var trans: [Meaning]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getWord(word: String) {
            networkService.getWords(word: word) { [weak self] response in
                guard let self = self else { return }
                self.arrayWords = response
                self.view?.succes()
                trans = response.flatMap { $0.meanings }
            }
        }
    }

