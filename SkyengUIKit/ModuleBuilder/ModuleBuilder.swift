//
//  ModuleBuilder.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import Foundation
import UIKit

protocol Builder {
  static func createMainView() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainView() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkManager()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}

