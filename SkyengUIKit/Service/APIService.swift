//
//  APIService.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func getWords(word: String, completion: @escaping ([WordsModelElement]) -> ())
}

final class NetworkManager: NetworkServiceProtocol {
    
    //MARK: - Private properties
    
    private let baseURL = "https://dictionary.skyeng.ru/api/public/v1/words/search"
    
    //MARK: - Fuctions
    
    func getWords(word: String, completion: @escaping ([WordsModelElement]) -> ()) {
        let url = baseURL
        let params: Parameters = [
            "search": word
        ]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            
            do {
                let arrayData = try JSONDecoder().decode([WordsModelElement].self, from: data)
                let wordsArray = arrayData
                DispatchQueue.main.async {
                    completion(wordsArray)
                }
            } catch {
                print("Ошибка в сетевом запросе")
            }
        }
    }
}

