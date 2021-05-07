//
//  AppRouter.swift
//  QuizApp
//
//  Created by five on 07/05/2021.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window : UIWindow?)
    func setTabViewController()
    func goToLoginViewController()
}

class AppRouter : AppRouterProtocol {
   
    private let navigationController : UINavigationController!
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)
        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setTabViewController() {
        let vc = TabViewController()
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
    
    func goToLoginViewController() {
        let vc = LoginViewController(router: self)
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
  
}
