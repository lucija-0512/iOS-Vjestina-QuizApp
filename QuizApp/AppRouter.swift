import Foundation
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window : UIWindow?)
    func setTabViewController()
    func goToLoginViewController()
    func goToRoot()
    func goToQuizViewController(quiz : Quiz)
    func goToQuizResultViewController(correct : Int, total : Int, quizId : Int)
    func presentLeaderboardViewController(board : [LeaderboardResult])
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
    
    func goToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
  
    func goToQuizViewController(quiz : Quiz) {
        let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.quiz = quiz
        pageViewController.router = self
        pageViewController.networkService = networkService
        navigationController?.pushViewController(pageViewController, animated: true)
    }
    
    func goToQuizResultViewController(correct : Int, total : Int, quizId : Int) {
        let targetController = QuizResultViewController(_correct: correct, _total : total, _router: self, _quizId: quizId, _networkService: networkService)
        navigationController?.pushViewController(targetController, animated: true)
    }
    
    func presentLeaderboardViewController(board : [LeaderboardResult]) {
        let leaderboardController = LeaderboardViewController(_result: board)
        //leaderboardController.modalPresentationStyle = .overFullScreen
        //navigationController?.present(leaderboardController, animated: true, completion: nil)
        let newController = UINavigationController(rootViewController: leaderboardController)
        newController.modalPresentationStyle = .overFullScreen
        navigationController?.present(newController, animated: true, completion: nil)
    }
}
