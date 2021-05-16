import Foundation
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window : UIWindow?)
    func setTabViewController()
    func goToLoginViewController()
    func goToQuizViewController(quiz : Quiz)
}

class AppRouter : AppRouterProtocol {
   
    private let navigationController : UINavigationController!
    private var networkService : NetworkService = NetworkService()
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self, networkService: networkService)
        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setTabViewController() {
        let vc = TabViewController(router: self, networkService: networkService)
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
    
    func goToLoginViewController() {
        let vc = LoginViewController(router: self, networkService: networkService)
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
  
    func goToQuizViewController(quiz : Quiz) {
        let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.quiz = quiz
        pageViewController.networkService = networkService
        navigationController?.pushViewController(pageViewController, animated: true)
    }
}
